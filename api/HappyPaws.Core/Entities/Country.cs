using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class Country : BaseEntity
    {
        public required string Name { get; set; }
        public required string CountryCode { get; set; }

        public required ICollection<City> Cities { get; set; }
    }
}
