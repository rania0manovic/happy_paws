using FluentValidation;
using HappyPaws.Core.Dtos.Notification;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class NotificationValidator : AbstractValidator<NotificationDto>
    {
        public NotificationValidator()
        {

        }
    }
}
