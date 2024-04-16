using HappyPaws.Core.Dtos.Order;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos
{
    public class OrderDetailDto : BaseDto
    {
        public int Quantity { get; set; }
        public double UnitPrice { get; set; }

        public OrderDto? Order { get; set; }
        public int OrderId { get; set; }

        public ProductDto? Product { get; set; }
        public int ProductId { get; set; }
    }
}
