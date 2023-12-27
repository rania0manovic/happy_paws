using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.ProductImage
{
    public class ProductImageDto:BaseDto
    {
        public required byte[] Data { get; set; }
        public required string ContentType { get; set; }
    }
}
