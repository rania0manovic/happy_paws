using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class ProductCategorySubcategory : BaseEntity
    {
        public ProductCategory ProductCategory { get; set; } = null!;
        public int ProductCategoryId { get; set; }

        public ProductSubcategory ProductSubcategory { get; set; } = null!;
        public int ProductSubcategoryId { get; set; }

        public ICollection<Product> Products { get; set; } = null!;
    }
}
