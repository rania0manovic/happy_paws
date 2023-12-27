using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Interfaces
{
    public interface IProductCategorySubcategoriesRepository : IBaseRepository<ProductCategorySubcategory, int>
    {
        Task<List<int>> GetSubcategoryIdsForCategory(int categoryId, CancellationToken cancellationToken = default, bool isDeletedIncluded = false);
        Task RemoveBySubcategoryIdAsync(int subcategoryId, CancellationToken cancellationToken = default);
        Task AddBySubcategoryIdAsync(int subcategoryId, CancellationToken cancellationToken = default);

    }
}
