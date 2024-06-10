using HappyPaws.Core.Dtos.Product;
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
        Task<Product?> GetByIdAsync(int id, int userId, CancellationToken cancellationToken = default);
        Task<List<Product>> GetBestsellersAsync(int size, CancellationToken cancellationToken = default);
        Task UpdateStockAsync(int id, int size, CancellationToken cancellationToken = default);
        Task<bool> HasAnyWithCategoryIdAsync(int categoryId, CancellationToken cancellationToken = default);
        Task<bool> HasAnyWithSubcategoryIdAsync(int subcategoryId, CancellationToken cancellationToken = default);
        Task<bool> HasAnyWithBrandIdAsync(int brandId, CancellationToken cancellationToken = default);

    }
}
