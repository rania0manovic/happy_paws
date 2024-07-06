using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class OrderDetail:BaseEntity
    {
        public int Quantity { get; set; }
        public double UnitPrice { get; set; }

        public Order Order { get; set; } = null!;
        public int OrderId { get; set; }

        public Product Product { get; set; } = null!;
        public int ProductId { get; set; }
    }
}
