using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Other;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class OrdersRepository : BaseRepository<Order, int, OrderSearchObject>, IOrdersRepository
    {
        public OrdersRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override Task<Order?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            return DbSet
                .Include(x => x.OrderDetails).ThenInclude(x => x.Product)
                     .ThenInclude(x => x.ProductImages).ThenInclude(x => x.Image)
                      .Include(x => x.OrderDetails).ThenInclude(x => x.Product)
                      .ThenInclude(x => x.ProductReviews)
                .Include(x => x.ShippingAddress)
                .Include(x => x.User)
                .Include(x => x.OrderDetails).ThenInclude(x => x.Product).ThenInclude(x => x.Brand)
                .FirstOrDefaultAsync(x => x.Id == id, cancellationToken);
        }

        public async Task<double> GetIncomeForMonthAsync(int month, CancellationToken cancellationToken = default)
        {
            if (month == 0)
            {
                return await DbSet.Where(x =>
                x.Status != OrderStatus.Returned
                && x.Status != OrderStatus.Refunded)
                .SumAsync(x => x.Total, cancellationToken);
            }
            return await DbSet.Where(x => x.CreatedAt.Month == month
                && x.CreatedAt.Year == DateTime.Now.Year
                && x.Status != OrderStatus.Returned
                && x.Status != OrderStatus.Refunded)
                .SumAsync(x => x.Total, cancellationToken);
        }

        public override async Task<PagedList<Order>> GetPagedAsync(OrderSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var query = DbSet
                .Include(x => x.ShippingAddress)
                .Include(x => x.User)
                .Include(x => x.OrderDetails).ThenInclude(x => x.Product).ThenInclude(x => x.Brand)
                .AsQueryable();
            if (searchObject.IncludePhotos == true)
            {
                query.Include(x => x.OrderDetails).ThenInclude(x => x.Product)
                     .ThenInclude(x => x.ProductImages).ThenInclude(x => x.Image);
            }
            return await query
                .Where(x => (searchObject.UserId == null || x.UserId == searchObject.UserId) &&
                 (searchObject.Id == null || x.Id.ToString().StartsWith(searchObject.Id)) &&
                 (searchObject.StartDateTime == null || x.CreatedAt >= searchObject.StartDateTime) &&
                (searchObject.EndDateTime == null || x.CreatedAt <= searchObject.EndDateTime)
               )
                .OrderBy(x => (int)(x.Status))
             .ToPagedListAsync(searchObject, cancellationToken);
        }

        public async Task<List<TopUserDto>> GetTopBuyersAsync(int size, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x => x.Status != OrderStatus.Returned && x.Status != OrderStatus.Refunded).GroupBy(x => x.UserId)
                          .OrderByDescending(g => g.Count())
                          .Take(size)
                             .Select(g => new TopUserDto()
                             {
                                 User = new UserDto()
                                 {
                                     FirstName = g.FirstOrDefault().User.FirstName,
                                     LastName = g.FirstOrDefault().User.LastName,
                                     ProfilePhotoId = g.FirstOrDefault().User.ProfilePhotoId,
                                     Gender = g.FirstOrDefault().User.Gender
                                 },
                                 TotalSpent = g.Sum(o => o.Total)
                             })
                          .ToListAsync(cancellationToken);
        }

        public async Task<bool> HasAnyByProductIdAsync(int productId, CancellationToken cancellationToken = default)
        {
            return await DbSet.AnyAsync(x => x.OrderDetails.Any(c => c.ProductId == productId), cancellationToken: cancellationToken);
        }
    }
}
