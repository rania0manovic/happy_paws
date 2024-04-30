﻿using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.User
{
    public class UserDto : UserBaseDto
    {
        public string MyPawNumber { get; set; } = null!;
        public bool IsVerified { get; set; }
        public string? ConnectionId { get; set; }

        public IFormFile? PhotoFile { get; set; }

    }
}
