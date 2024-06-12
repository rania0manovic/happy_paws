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
        public required string UPC { get; set; }
        public double Price { get; set; }
        public required string Description { get; set; }
        public int InStock { get; set; }
        public bool? IsActive { get; set; }

        public Brand Brand { get; set; } = null!;
        public int BrandId { get; set; }

        public ProductCategorySubcategory ProductCategorySubcategory { get; set; } = null!;
        public int ProductCategorySubcategoryId { get; set; }

        public ICollection<ProductImage>? ProductImages { get; set; }
        public ICollection<OrderDetail>? OrderDetails { get; set; }
        public ICollection<ProductReview>? ProductReviews { get; set; }
        public ICollection<UserCart>? UserCartItems { get; set; }
        public ICollection<UserFavourite>? UserFavouriteItems { get; set; }
    }
}
