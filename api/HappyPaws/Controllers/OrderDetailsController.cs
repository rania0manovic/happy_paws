using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{

    public class OrderDetailsController : BaseCrudController<OrderDetailDto, IOrderDetailsService, OrderDetailSearchObject>
    {
        public OrderDetailsController(IOrderDetailsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
