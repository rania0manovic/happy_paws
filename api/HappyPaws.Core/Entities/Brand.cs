using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class Brand:BaseEntity
    {
        public required string Name { get; set; }

        public required ICollection<Product> Products { get; set; }
    }
}
