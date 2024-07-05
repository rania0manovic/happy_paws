using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.OrderDetail;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [Authorize]
    public class OrderDetailsController : BaseCrudController<OrderDetailDto, IOrderDetailsService, OrderDetailSearchObject>
    {
        public OrderDetailsController(IOrderDetailsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
