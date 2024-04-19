using HappyPaws.Core.Dtos.Order;
using HappyPaws.Core.Enums;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IOrdersService : IBaseService<int, OrderDto, OrderSearchObject>
    {
        Task UpdateAsync(int id,OrderStatus status, CancellationToken cancellationToken = default);
        Task SendPlacedOrderConfirmation(int id, CancellationToken cancellationToken= default); 
    }
}
