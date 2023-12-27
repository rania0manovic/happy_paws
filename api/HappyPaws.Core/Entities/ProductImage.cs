using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class ProductImage : BaseEntity
    {
        public required Product Product { get; set; }
        public int ProductId { get; set; }

        public required Image Image { get; set; }
        public int ImageId { get; set; }
    }
}
