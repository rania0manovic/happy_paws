using HappyPaws.Core.Dtos.Address;
using HappyPaws.Core.Dtos.OrderDetail;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Order
{
    public class OrderDto : BaseDto
    {
        public DateTime OrderDate { get; set; }
        public OrderStatus Status { get; set; }
        public PaymentMethod PaymentMethod { get; set; }
        public string? PayId { get; set; }
        public double? Shipping { get; set; }
        public double Total { get; set; }

        public UserDto? User { get; set; }
        public int UserId { get; set; }

        public UserAddressDto? ShippingAddress { get; set; }
        public int? ShippingAddressId { get; set; }

        public ICollection<OrderDetailDto>? OrderDetails { get; set; }

    }
}
