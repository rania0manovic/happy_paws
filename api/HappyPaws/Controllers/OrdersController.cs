using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Order;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace HappyPaws.Api.Controllers
{
    public class OrdersController : BaseCrudController<OrderDto, IOrdersService, OrderSearchObject>
    {
        protected readonly CurrentUser _currentUser;
        public OrdersController(IOrdersService service, ILogger<BaseController> logger, CurrentUser currentUser) : base(service, logger)
        {
            _currentUser = currentUser;
        }
        public override async Task<IActionResult> Post([FromBody] OrderDto upsertDto, CancellationToken cancellationToken = default)
        {
            var userId = _currentUser.Id;
            if (!userId.HasValue) throw new Exception("Unauthorized!");
            upsertDto.UserId = userId.Value;
            var dto = await Service.AddAsync(upsertDto, cancellationToken);
            await Service.SendPlacedOrderConfirmation(dto.Id, cancellationToken);
            return Ok(dto);

        }
        [HttpPut("{id}/{status}")]
        public async Task<IActionResult> Put(int id, OrderStatus status, CancellationToken cancellationToken = default)
        {
            try
            {
                await Service.UpdateAsync(id, status, cancellationToken);
                return Ok();
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when updating resource");
                return BadRequest();
            }
        }
    }
}
