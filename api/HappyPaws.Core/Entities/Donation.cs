using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class Donation : BaseEntity
    {
        public double Amount { get; set; }

        public required User User { get; set; }
        public int UserId { get; set; }
    }
}
