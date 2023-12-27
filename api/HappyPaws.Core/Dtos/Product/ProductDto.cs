using HappyPaws.Core.Dtos.Brand;
using HappyPaws.Core.Dtos.ProductSubcategory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Product
{
    public class ProductDto:BaseDto
    {
        public required string Name { get; set; }
        public double Price { get; set; }
        public required string Description { get; set; }
        public int InStock { get; set; }

        public required BrandDto Brand { get; set; }
        public int BrandId { get; set; }

        public required ProductSubcategoryDto ProductSubcategory { get; set; }
        public int ProductSubcategoryId { get; set; }
    }
}
