using AutoMapper;
using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.Dtos.Notification;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class NotificationProfile : BaseProfile
    {
        public NotificationProfile()
        {
            CreateMap<Notification, NotificationDto>().ReverseMap();

        }
    }
}
