using HappyPaws.Core.Dtos.Brand;
using HappyPaws.Core.Dtos.ProductCategorySubcategory;
using HappyPaws.Core.Dtos.ProductImage;
using HappyPaws.Core.Dtos.ProductReview;
using HappyPaws.Core.Dtos.ProductSubcategory;
using HappyPaws.Core.Dtos.UserCart;
using HappyPaws.Core.Dtos.UserFavourite;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Product
{
    public class ProductDto : BaseDto
    {
        public string Name { get; set; } = null!;
        public double Price { get; set; }
        public string Description { get; set; } = null!;
        public int InStock { get; set; }

        public BrandDto? Brand { get; set; }
        public int BrandId { get; set; }

        public ProductCategorySubcategoryDto? ProductCategorySubcategory { get; set; } 
        public int ProductCategorySubcategoryId { get; set; }

        public List<IFormFile>? ImageFiles { get; set; }
        public ICollection<ProductImageDto>? ProductImages { get; set; }
        public ICollection<ProductReviewDto>? ProductReviews { get; set; }
        public ICollection<UserCartDto>? UserCartItems { get; set; }
        public ICollection<UserFavouriteDto>? UserFavouriteItems { get; set; }
    }
}
