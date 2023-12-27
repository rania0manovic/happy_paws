using HappyPaws.Core.Dtos.ProductCategory;
using HappyPaws.Core.Dtos.ProductSubcategory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.ProductCategorySubcategory
{
    public class ProductCategorySubcategoryDto:BaseDto
    {
        public ProductCategoryDto ProductCategory { get; set; } = null!;
        public int ProductCategoryId { get; set; }

        public ProductSubcategoryDto ProductSubcategory { get; set; } = null!;
        public int ProductSubcategoryId { get; set; }

        
    }
}
