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

        public override async Task<PagedList<Order>> GetPagedAsync(OrderSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x=>x.OrderDetails).ThenInclude(x=>x.Product).ThenInclude(x=>x.ProductImages).ThenInclude(x=>x.Image)
                .Include(x=>x.ShippingAddress)
                .Where(x=> searchObject.UserId==null || x.ShippingAddress.UserId==searchObject.UserId)
                .ToPagedListAsync(searchObject, cancellationToken);   
        }
    }
}
