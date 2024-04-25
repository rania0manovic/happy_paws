﻿using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Notification;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class NotificationsController : BaseCrudController<NotificationDto, INotificationsService, NotificationSearchObject>
    {
        private readonly CurrentUser user;
        public NotificationsController(INotificationsService service, ILogger<BaseController> logger, CurrentUser user) : base(service, logger)
        {
            this.user = user;
        }
        public override Task<IActionResult> GetPaged([FromQuery] NotificationSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            if (user.Id.HasValue)
            {
                searchObject.UserId = user.Id.Value;
                return base.GetPaged(searchObject, cancellationToken);
            }
            throw new UnauthorizedAccessException();
        }
    }
}
