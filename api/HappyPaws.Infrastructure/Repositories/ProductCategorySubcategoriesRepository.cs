using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class ProductCategorySubcategoriesRepository : BaseRepository<ProductCategorySubcategory, int>, IProductCategorySubcategoriesRepository
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

        public async Task<List<int>> GetSubcategoryIdsForCategory(int categoryId, CancellationToken cancellationToken = default, bool isDeletedIncluded = false)
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
