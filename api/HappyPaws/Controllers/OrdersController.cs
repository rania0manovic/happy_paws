using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Api.Hubs.MessageHub;
using HappyPaws.Application.Interfaces;
using HappyPaws.Application.Services;
using HappyPaws.Core.Dtos.Notification;
using HappyPaws.Core.Dtos.Order;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace HappyPaws.Api.Controllers
{
    public class OrdersController : BaseCrudController<OrderDto, IOrdersService, OrderSearchObject>
    {
        protected readonly CurrentUser _currentUser;
        protected readonly IUsersService _usersService;
        protected readonly INotificationsService _notificationsService;
        private readonly IHubContext<MessageHub> _hubContext;
        public OrdersController(IOrdersService service, ILogger<BaseController> logger, CurrentUser currentUser, IUsersService usersService, INotificationsService notificationsService, IHubContext<MessageHub> hubContext) : base(service, logger)
        {
            _currentUser = currentUser;
            _usersService = usersService;
            _notificationsService = notificationsService;
            _hubContext = hubContext;
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
        [HttpPut("{id}/{status}/{userId}")]
        public async Task<IActionResult> Put(int id, OrderStatus status, int userId, CancellationToken cancellationToken = default)
        {
            try
            {
                await Service.UpdateAsync(id, status, cancellationToken);
                
                var orderStatus = Regex.Replace(status.ToString(), @"(?<!^)(?=[A-Z])", " ");
                orderStatus = char.ToUpper(orderStatus[0]) + orderStatus.Substring(1).ToLower();
                var notification = new NotificationDto
                {
                    Message = "Your order ID " + id + " has new order status: " + orderStatus + "!",
                    Title = "Order update",
                    UserId = userId
                };

                var connectionId = await _usersService.GetConnectionId(notification.UserId, cancellationToken);
                var notificationResponse = await _notificationsService.AddAsync(notification, cancellationToken);
                if (connectionId != null)
                {
                    await _hubContext.Clients.Client(connectionId).SendAsync("NewNotification", notificationResponse, cancellationToken: cancellationToken);
                }
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
