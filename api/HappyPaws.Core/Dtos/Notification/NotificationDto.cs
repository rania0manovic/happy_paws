using HappyPaws.Core.Dtos.User;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Notification
{
    public class NotificationDto:BaseDto
    {
        public required string Title { get; set; }
        public required string Message { get; set; }
        public bool Seen { get; set; }

        public  UserDto? User { get; set; }
        public int UserId { get; set; }
    }
}
