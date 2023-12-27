using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class Product : BaseEntity
    {
        public required string Name { get; set; }
        public double Price { get; set; }
        public required string Description { get; set; }
        public int InStock { get; set; }

        public required Brand Brand { get; set; }
        public int BrandId { get; set; }

        public required ProductCategorySubcategory ProductCategorySubcategory { get; set; }
        public required int ProductCategorySubcategoryId { get; set; }


        public required ICollection<ProductImage> ProductImages { get; set; }
        public required ICollection<ProductReview> ProductReviews { get; set; }
        public required ICollection<UserCart> UserCartItems { get; set; }
        public required ICollection<UserFavourite> UserFavouriteItems { get; set; }
    }
}
