using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Donation
{
    public class DonationDto : BaseDto
    {
        public double Amount { get; set; }

        public UserDto? User { get; set; }
        public int UserId { get; set; }
    }
}
