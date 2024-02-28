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
    public class ProductSubcategoriesRepository : BaseRepository<ProductSubcategory, int, ProductSubcategorySearchObject>, IProductSubcategoriesRepository
    {
        public ProductSubcategoriesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<ProductSubcategory>> GetPagedAsync(ProductSubcategorySearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x => x.Photo).Where(x => !x.IsDeleted).ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
