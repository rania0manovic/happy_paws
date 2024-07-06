using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Interfaces
{
    public interface IOrdersRepository : IBaseRepository<Order, int, OrderSearchObject>
    {
        Task<List<TopUserDto>> GetTopBuyersAsync(int size, CancellationToken cancellationToken = default);
        Task<double> GetIncomeForMonthAsync(int month, CancellationToken cancellationToken = default);
        Task<bool> HasAnyByProductIdAsync(int productId, CancellationToken cancellationToken = default);
    }
}
