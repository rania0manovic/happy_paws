using HappyPaws.Core.Entities;
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
                .Include(x => x.ShippingAddress)
                .Include(x => x.User)
                .Include(x => x.OrderDetails).ThenInclude(x => x.Product).ThenInclude(x => x.Brand)
                .FirstOrDefaultAsync(x => x.Id == id, cancellationToken);
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
            return await query.Where(x => searchObject.UserId == null || x.UserId == searchObject.UserId)
             .ToPagedListAsync(searchObject, cancellationToken);
        }

    }
}
