using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Order;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class OrdersController : BaseCrudController<OrderDto, IOrdersService, OrderSearchObject>
    {
        protected readonly CurrentUser _currentUser;
        public OrdersController(IOrdersService service, ILogger<BaseController> logger, CurrentUser currentUser) : base(service, logger)
        {
            _currentUser = currentUser;
        }
        public override Task<IActionResult> Post([FromBody] OrderDto upsertDto, CancellationToken cancellationToken = default)
        {
            var userId = _currentUser.Id;
            if (!userId.HasValue) throw new Exception("Unauthorized!");
            upsertDto.UserId=userId.Value;
            return base.Post(upsertDto, cancellationToken);
        }
    }
}
