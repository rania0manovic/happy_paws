using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.User
{
    public class UserDto:UserBaseDto
    {
        public required string MyPawNumber { get; set; }
        public bool IsVerified { get; set; }
        public IFormFile? PhotoFile { get; set; }

    }
}
