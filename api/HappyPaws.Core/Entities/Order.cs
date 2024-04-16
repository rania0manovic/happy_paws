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
        public DateTime OrderDate { get; set; }
        public OrderStatus Status { get; set; }
        public PaymentMethod PaymentMethod { get; set; }
        public double? Shipping { get; set; }
        public double Total { get; set; }

        public UserAddress ? ShippingAddress { get; set; }
        public int ? ShippingAddressId { get; set; }

        public required ICollection<OrderDetail> OrderDetails { get; set; }

    }
}
