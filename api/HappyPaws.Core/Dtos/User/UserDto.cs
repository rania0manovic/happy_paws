using HappyPaws.Core.Enums;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.User
{
    public class UserDto : UserBaseDto
    {
        public string? MyPawNumber { get; set; }
        public bool IsVerified { get; set; }
        public string? ConnectionId { get; set; }
        public EmployeePosition? EmployeePosition { get; set; }
        public string? DownloadURL { get; set; }
        public bool IsSubscribed { get; set; }

        public IFormFile? PhotoFile { get; set; }

    }
}
