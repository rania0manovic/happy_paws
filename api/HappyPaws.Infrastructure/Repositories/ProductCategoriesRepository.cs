using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Other;
using Microsoft.EntityFrameworkCore;

namespace HappyPaws.Infrastructure.Repositories
{
    public class ProductCategoriesRepository : BaseRepository<ProductCategory, int, ProductCategorySearchObject>, IProductCategoriesRepository
    {
        public ProductCategoriesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<ProductCategory>> GetPagedAsync(ProductCategorySearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x => x.Photo)
                .Where(x => searchObject.Name == null || x.Name.Contains(searchObject.Name))
                .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
