using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Api.Hubs.MessageHub;
using HappyPaws.Application.Interfaces;
using HappyPaws.Application.Services;
using HappyPaws.Core.Dtos.Helpers;
using HappyPaws.Core.Dtos.Notification;
using HappyPaws.Core.Dtos.Order;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Caching.Memory;
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
        private readonly IMemoryCache _memoryCache;
        public OrdersController(IOrdersService service, ILogger<BaseController> logger, CurrentUser currentUser, IUsersService usersService, INotificationsService notificationsService, IHubContext<MessageHub> hubContext, IMemoryCache memoryCache) : base(service, logger)
        {
            _currentUser = currentUser;
            _usersService = usersService;
            _notificationsService = notificationsService;
            _hubContext = hubContext;
            _memoryCache = memoryCache;
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
        //TODO: temporary approach, make sure query checks at database whether there's reviews left by user (now it fetches all reviews from db and checks on api layer which slows down server)
        public override async Task<IActionResult> Get(int id, CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await Service.GetByIdAsync(id, cancellationToken);
                if (response != null && _currentUser.Id.HasValue)
                {
                    foreach (var item in response.OrderDetails)
                    {
                        foreach (var review in item.Product.ProductReviews)
                        {
                            if (review.ProductId == item.ProductId && review.ReviewerId == _currentUser.Id.Value)
                            {
                                item.Product.HasReview = true;
                            }
                        }
                    }
                    return Ok(response);
                }
                else throw new UnauthorizedAccessException();
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when fetching resources.");
                return BadRequest();
            }
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

        [HttpGet("GetTopBuyers")]
        public async Task<IActionResult> GetTopBuyers(int size, CancellationToken cancellationToken = default)
        {
            try
            {
                if (_memoryCache.TryGetValue<List<TopUserDto>>("topBuyers", out var topBuyers))
                {
                    return Ok(topBuyers);
                }
                var response = await Service.GetTopBuyersAsync(size, cancellationToken);
                _memoryCache.Set("topBuyers", response, TimeSpan.FromDays(1));
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when fetching resources about top buyers!");
                return BadRequest();
            }
        }

        [HttpGet("HasAnyByProductId/{productId}")]
        public async Task<IActionResult> HasAnyByProductId(int productId, CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await Service.HasAnyByProductIdAsync(productId, cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when checking for any orders with product id {productId} in it!", productId);
                return BadRequest();
            }
        }
    }
}
