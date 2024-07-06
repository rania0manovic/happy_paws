using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class UserAddress : BaseEntity
    {
        public required string FullName { get; set; }
        public required string AddressOne { get; set; }
        public string? AddressTwo { get; set; }
        public required string City { get; set; }
        public required string Country { get; set; }
        public required string PostalCode { get; set; }
        public required string Phone { get; set; }
        public string? Note { get; set; }
        public bool IsInitialUserAddress { get; set; }

        public User User { get; set; } = null!;
        public int UserId { get; set; }

        public ICollection<Order> Orders { get; set; } = null!;
    }
}
