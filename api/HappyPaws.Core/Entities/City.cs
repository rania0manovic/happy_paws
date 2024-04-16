using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class City : BaseEntity
    {
        public required string Name { get; set; }

        public required Country Country { get; set; }
        public int CountryId { get; set; }

        public required ICollection<UserAddress> Addresses { get; set; }
    }
}
