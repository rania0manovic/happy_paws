using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Other;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Interfaces
{
    public interface IProductsRepository : IBaseRepository<Product, int, ProductSearchObject>
    {
        Task<PagedList<Product>> GetPagedByCategoryIdAndSubcategoryIdAsync(ProductSearchObject searchObject, CancellationToken cancellationToken=default);
    }
}
