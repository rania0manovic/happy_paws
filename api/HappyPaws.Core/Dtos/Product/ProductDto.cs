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
        public ProductDto()
        {
            NewStockValue = InStock;
        }
        public string Name { get; set; } = null!;
        public string UPC { get; set; } = null!;
        public double Price { get; set; }
        public string Description { get; set; } = null!;
        public int InStock { get; set; }
        public int NewStockValue { get; set; }
        public bool? IsActive { get; set; }

        public bool IsFavourite { get; set; }
        public bool HasReview { get; set; }
        public int Review { get; set; }
        public int UserFavouriteId { get; set; }

        public BrandDto? Brand { get; set; }
        public int BrandId { get; set; }

        public ProductCategorySubcategoryDto? ProductCategorySubcategory { get; set; }
        public int ProductCategorySubcategoryId { get; set; }

        public List<string>? DownloadURLs { get; set; }
        public ICollection<ProductImageDto>? ProductImages { get; set; }
        public ICollection<ProductReviewDto>? ProductReviews { get; set; }
        public ICollection<UserCartDto>? UserCartItems { get; set; }
        public ICollection<UserFavouriteDto>? UserFavouriteItems { get; set; }
    }
}
