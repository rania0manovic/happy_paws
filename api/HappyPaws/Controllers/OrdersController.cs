using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Order;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class OrdersController : BaseCrudController<OrderDto, IOrdersService>
    {
        public OrdersController(IOrdersService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
