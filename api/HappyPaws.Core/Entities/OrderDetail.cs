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

        public required Order Order { get; set; }
        public int OrderId { get; set; }

        public required Product Product { get; set; }
        public int ProductId { get; set; }
    }
}
