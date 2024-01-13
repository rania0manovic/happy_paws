using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
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
    public class ProductsRepository : BaseRepository<Product, int>, IProductsRepository
    {
        public ProductsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<Product>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x => x.ProductCategorySubcategory).ThenInclude(x => x.ProductCategory)
                .Include(x => x.ProductCategorySubcategory).ThenInclude(x => x.ProductSubcategory)
                .Include(x=>x.ProductImages).ThenInclude(x=>x.Image)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
