using HappyPaws.Core.Dtos.Image;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class ProductCategory : BaseEntity
    {
        public required string Name { get; set; }

        public Image Photo { get; set; } = null!;
        public int PhotoId { get; set; }

        public ICollection<ProductCategorySubcategory>? ProductCategorySubcategories { get; set; }


    }
}
