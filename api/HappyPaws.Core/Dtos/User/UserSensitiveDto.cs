using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.User
{
    public class UserSensitiveDto:UserDto
    {
        public required string PasswordHash { get; set; }
        public required string PasswordSalt { get; set; }
    }
}
