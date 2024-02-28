using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Order;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class OrdersController : BaseCrudController<OrderDto, IOrdersService, OrderSearchObject>
    {
        public OrdersController(IOrdersService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
