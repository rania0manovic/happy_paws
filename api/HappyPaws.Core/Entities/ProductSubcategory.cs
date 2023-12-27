using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class ProductSubcategory : BaseEntity
    {
        public required string Name { get; set; }

        public required Image Photo { get; set; }
        public int PhotoId { get; set; }

        public required ICollection<ProductCategorySubcategory> ProductCategorySubcategories { get; set; }
    }
}
