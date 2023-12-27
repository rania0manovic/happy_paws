using HappyPaws.Core.Dtos.User;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.EmailVerificationRequest
{
    public class EmailVerificationRequestDto : BaseDto
    {
        public int Code { get; set; }
        public required string Email { get; set; }
    }
}
