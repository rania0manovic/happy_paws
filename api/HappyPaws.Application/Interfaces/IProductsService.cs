using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IProductsService : IBaseService<int, ProductDto, ProductSearchObject>
    {
        Task<ProductDto?> GetByIdAsync(int id, int userId, CancellationToken cancellationToken = default);
        Task<List<ProductDto>> GetBestsellersAsync(int size, CancellationToken cancellationToken = default);
        Task UpdateStockAsync(int id, int size, CancellationToken cancellation = default);
        Task UpdateActivityStatusAsync(int id, bool isActive, CancellationToken cancellation = default);
        Task<bool> HasAnyWithCategoryIdAsync(int categoryId, CancellationToken cancellationToken = default);
        Task<bool> HasAnyWithSubcategoryIdAsync(int subcategoryId, CancellationToken cancellationToken = default);
        Task<bool> HasAnyWithBrandIdAsync(int brandId, CancellationToken cancellationToken = default);

    }
}
