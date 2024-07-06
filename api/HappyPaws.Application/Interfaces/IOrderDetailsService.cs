using HappyPaws.Core.Dtos.OrderDetail;
using HappyPaws.Core.SearchObjects;

namespace HappyPaws.Application.Interfaces
{
    public interface IOrderDetailsService : IBaseService<int, OrderDetailDto, OrderDetailSearchObject>
    {
    }
}
