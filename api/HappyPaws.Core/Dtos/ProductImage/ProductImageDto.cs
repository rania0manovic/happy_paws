using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.Dtos.Product;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.ProductImage
{
    public class ProductImageDto : BaseDto
    {
        public ProductDto? Product { get; set; }
        public int ProductId { get; set; }

        public ImageDto? Image { get; set; }
        public int ImageId { get; set; }
    }
}
