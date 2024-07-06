using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Models
{
    public class SignInModel
    {
        public required string Email { get; set; } 
        public required string Password { get; set; }
        public bool AdminPanel { get; set; } = false;
    }
}
