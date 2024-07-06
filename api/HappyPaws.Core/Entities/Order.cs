using HappyPaws.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class Order : BaseEntity
    {
        public OrderStatus Status { get; set; }
        public PaymentMethod PaymentMethod { get; set; }
        public string? PayId { get; set; }
        public double? Shipping { get; set; }
        public double Total { get; set; }

        public User User { get; set; } = null!;
        public int UserId { get; set; }

        public UserAddress? ShippingAddress { get; set; }
        public int? ShippingAddressId { get; set; }

        public ICollection<OrderDetail> OrderDetails { get; set; } = null!;

    }
}
