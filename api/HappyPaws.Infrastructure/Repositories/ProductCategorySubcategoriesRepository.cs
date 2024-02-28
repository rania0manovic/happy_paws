using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class ProductCategorySubcategoriesRepository : BaseRepository<ProductCategorySubcategory, int, ProductCategorySubcategorySearchObject>, IProductCategorySubcategoriesRepository
    {
        public ProductCategorySubcategoriesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async Task AddBySubcategoryIdAsync(int subcategoryId, CancellationToken cancellationToken = default)
        {
            await DbSet.Where(x => x.ProductSubcategoryId.Equals(subcategoryId)).ExecuteUpdateAsync(x => x
                  .SetProperty(x => x.IsDeleted, false)
                  .SetProperty(x => x.ModifiedAt, DateTime.Now), cancellationToken);
        }

        public async Task<List<ProductCategorySubcategory>> GetSubcategoriesForCategoryAsync(int categoryId, bool includePhotos = false, CancellationToken cancellationToken = default, bool isDeletedIncluded = false)
        {
            var query = DbSet.AsQueryable();

            if (includePhotos)
                query = query.Include(x => x.ProductSubcategory).ThenInclude(x => x.Photo);
            else
                query = query.Include(x => x.ProductSubcategory);

            query = query.Where(x => x.ProductCategoryId == categoryId && (isDeletedIncluded || !x.IsDeleted));

            return await query.ToListAsync(cancellationToken);

        }

        public async Task<List<int>> GetSubcategoryIdsForCategoryAsync(int categoryId, CancellationToken cancellationToken = default, bool isDeletedIncluded = false)
        {
            return await DbSet.Where(x => x.ProductCategoryId == categoryId && (isDeletedIncluded ? true : x.IsDeleted == false)).Select(x => x.ProductSubcategoryId).ToListAsync(cancellationToken);
        }

        public async Task RemoveBySubcategoryIdAsync(int subcategoryId, CancellationToken cancellationToken = default)
        {
            await DbSet.Where(x => x.ProductSubcategoryId.Equals(subcategoryId)).ExecuteUpdateAsync(x => x
                   .SetProperty(x => x.IsDeleted, true)
                   .SetProperty(x => x.ModifiedAt, DateTime.Now), cancellationToken);

        }
    }
}
