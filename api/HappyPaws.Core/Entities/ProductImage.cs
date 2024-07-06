using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class ProductImage : BaseEntity
    {
        public Product Product { get; set; } = null!;
        public int ProductId { get; set; }

        public Image Image { get; set; } = null!;
        public int ImageId { get; set; }
    }
}
