using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class Address : BaseEntity
    {
        public required string AddressOne { get; set; }
        public string? AddressTwo { get; set; }
        public required string PostalCode { get; set; }
        public string? Note { get; set; }

        public required City City { get; set; }
        public int CityId { get; set; }

        public required ICollection<Order> Orders { get; set; }
    }
}
