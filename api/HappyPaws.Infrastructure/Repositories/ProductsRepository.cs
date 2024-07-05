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
using System.Threading;
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
            var result = DbSet.Include(x => x.ProductCategorySubcategory).ThenInclude(x => x.ProductCategory)
                .Include(x => x.ProductCategorySubcategory).ThenInclude(x => x.ProductSubcategory)
                .Include(x => x.ProductReviews)
                .Include(x => x.ProductImages).ThenInclude(x => x.Image)
                .Where(x => (searchObject.SubcategoryId == null || x.ProductCategorySubcategory.ProductSubcategoryId == searchObject.SubcategoryId)
                && (searchObject.CategoryId == null || x.ProductCategorySubcategory.ProductCategoryId == searchObject.CategoryId)
                && (searchObject.SearchParams == null || x.UPC.StartsWith(searchObject.SearchParams) || x.Name.Contains(searchObject.SearchParams) || x.Brand.Name.Contains(searchObject.SearchParams))
                && (searchObject.OnlyActive == false || x.IsActive == true)
                && (searchObject.RecommendedProductIds == null || searchObject.RecommendedProductIds.Contains(x.Id))
                && (searchObject.MinReview == null || x.ProductReviews.Average(x=>x.Review)>=searchObject.MinReview)
                ).AsQueryable();
            if (searchObject.LowestPriceFirst != null)
            {
                if (searchObject.LowestPriceFirst == true)
                {
                    result = result.OrderBy(x => x.Price);
                }
                else
                    result = result.OrderByDescending(x => x.Price);
            }
            if (searchObject.OrderByDate != null)
            {
                result = result.OrderByDescending(x => x.CreatedAt);
            }
            return await result.ToPagedListAsync(searchObject, cancellationToken);
        }
        public override async Task<Product?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            return await DbSet.
                Include(x => x.ProductCategorySubcategory).ThenInclude(x => x.ProductCategory)
                .Include(x => x.ProductCategorySubcategory).ThenInclude(x => x.ProductSubcategory)
                .Include(x => x.ProductImages).ThenInclude(x => x.Image)
                .FirstOrDefaultAsync(x => x.Id == id, cancellationToken);
        }
        public async Task<Product?> GetByIdAsync(int id, int userId, CancellationToken cancellationToken = default)
        {
            return await DbSet.
                Include(x => x.ProductCategorySubcategory).ThenInclude(x => x.ProductCategory)
                .Include(x => x.ProductCategorySubcategory).ThenInclude(x => x.ProductSubcategory)
                .Include(x => x.ProductImages).ThenInclude(x => x.Image)
                .Include(x => x.UserFavouriteItems.Where(x => x.UserId == userId))
                .Include(x => x.ProductReviews)
                .FirstOrDefaultAsync(x => x.Id == id, cancellationToken);
        }


        public async Task<List<Product>> GetBestsellersAsync(int size, CancellationToken cancellationToken = default)
        {
            return await DbSet
                .Include(x => x.ProductImages).ThenInclude(x => x.Image)
             .OrderByDescending(p => p.OrderDetails.Sum(od => od.Quantity))
             .Take(size)
             .ToListAsync(cancellationToken: cancellationToken);
        }

        public async Task UpdateStockAsync(int id, int size, CancellationToken cancellationToken = default)
        {
            await DbSet.Where(e => e.Id.Equals(id)).ExecuteUpdateAsync(p => p
                  .SetProperty(e => e.InStock, size), cancellationToken);
        }

        public async Task<bool> HasAnyWithCategoryIdAsync(int categoryId, CancellationToken cancellationToken = default)
        {
            return await DbSet.AnyAsync(x => x.ProductCategorySubcategory.ProductCategoryId == categoryId, cancellationToken);
        }

        public async Task<bool> HasAnyWithSubcategoryIdAsync(int subcategoryId, CancellationToken cancellationToken = default)
        {
            return await DbSet.AnyAsync(x => x.ProductCategorySubcategory.ProductSubcategoryId == subcategoryId, cancellationToken);
        }

        public async Task<bool> HasAnyWithBrandIdAsync(int brandId, CancellationToken cancellationToken = default)
        {
            return await DbSet.AnyAsync(x => x.BrandId == brandId, cancellationToken);

        }
    }
}


