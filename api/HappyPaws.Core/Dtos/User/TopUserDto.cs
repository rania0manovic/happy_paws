using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.User
{
    public class TopUserDto
    {
        public double TotalSpent { get; set; }

        public required UserDto User { get; set; }
        public int UserId { get; set; }
    }
}
