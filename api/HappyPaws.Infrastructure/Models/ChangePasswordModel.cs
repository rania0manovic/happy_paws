using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Models
{
    public class ChangePasswordModel
    {
        public required string OldPassword { get; set; }
        public required string NewPassword { get; set; }
        public required string Email { get; set; }
      
    }
}
