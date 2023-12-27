using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Other;
using Microsoft.EntityFrameworkCore;

namespace HappyPaws.Infrastructure.Repositories
{
    public class ProductCategoriesRepository : BaseRepository<ProductCategory, int>, IProductCategoriesRepository
    {
        public ProductCategoriesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<ProductCategory>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x=>x.Photo).Where(x=>!x.IsDeleted).ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
