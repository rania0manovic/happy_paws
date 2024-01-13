using HappyPaws.Core.Dtos.ProductCategorySubcategory;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IProductCategorySubcategoriesService:IBaseService<int, ProductCategorySubcategoryDto>
    {
        Task<List<int>> GetSubcategoryIdsForCategoryAsync(int categoryId, CancellationToken cancellationToken = default);
        Task<List<ProductCategorySubcategoryDto>> GetSubcategoriesForCategoryAsync(int categoryId, CancellationToken cancellationToken = default, bool isDeletedIncluded = false);


    }
}
