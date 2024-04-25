using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Other;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class ProductsRepository : BaseRepository<Product, int, ProductSearchObject>, IProductsRepository
    {
        public ProductsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<Product>> GetPagedAsync(ProductSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x => x.ProductCategorySubcategory).ThenInclude(x => x.ProductCategory)
                .Include(x => x.ProductCategorySubcategory).ThenInclude(x => x.ProductSubcategory)
                .Include(x => x.ProductImages.Take(searchObject.TakePhotos)).ThenInclude(x => x.Image)
                .Where(x => (searchObject.SubcategoryId == null || x.ProductCategorySubcategory.ProductSubcategoryId == searchObject.SubcategoryId)
                && (searchObject.CategoryId == null || x.ProductCategorySubcategory.ProductCategoryId == searchObject.CategoryId)
                && (searchObject.CategoryId == null || x.ProductCategorySubcategory.ProductCategoryId == searchObject.CategoryId)
                && (searchObject.ProductOrBrandName == null || (x.Name.Contains(searchObject.ProductOrBrandName) || x.Brand.Name.Contains(searchObject.ProductOrBrandName)))
                ).ToPagedListAsync(searchObject, cancellationToken);
        }

        public async Task<Product?> GetByIdAsync(int id, int userId, CancellationToken cancellationToken = default)
        {
            return await DbSet
                .Include(x => x.ProductImages).ThenInclude(x => x.Image)
                .Include(x => x.UserFavouriteItems.Where(x => x.UserId == userId))
                .FirstOrDefaultAsync(x => x.Id == id, cancellationToken);
        }

        public async Task<List<Product>> FindSimilarProductsAsync(List<ProductDto> favouriteProducts, int size, CancellationToken cancellationToken = default)
        {
            var favoriteCategorySubcategoryIds = favouriteProducts.Select(p => p.ProductCategorySubcategoryId).Distinct();
            var favoriteBrandIds = favouriteProducts.Select(p => p.BrandId).Distinct();
            var averagePrice = favouriteProducts.Average(p => p.Price);


            var filteredProducts = await DbSet.Include(x=>x.ProductImages).ThenInclude(x => x.Image)
                  .Where(p => !favouriteProducts.Select(x=>x.Id).Contains(p.Id)
                  && favoriteCategorySubcategoryIds.Contains(p.ProductCategorySubcategoryId)
                  && favoriteBrandIds.Contains(p.BrandId)).
                  OrderBy(p => Math.Abs(p.Price - averagePrice))
                  .ToListAsync(cancellationToken: cancellationToken);

            var similarProducts = filteredProducts.Take(size).ToList();

            return similarProducts;
        }

        public async Task<List<Product>> GetBestsellersAsync(int size, CancellationToken cancellationToken = default)
        {
            return await DbSet
                .Include(x => x.ProductImages.Take(1)).ThenInclude(x => x.Image)
             .OrderByDescending(p => p.OrderDetails.Sum(od => od.Quantity))
             .Take(size)
             .ToListAsync(cancellationToken: cancellationToken);
        }
    }
}

