using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class EmailVerificationRequest : BaseEntity
    {
        public int Code { get; set; }
        public bool IsExpired { get; set; }
        public required string Email { get; set; }


    }
}
