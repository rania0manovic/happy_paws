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
        Task<List<ProductDto>> GetRecommendedProductsForUserAsync(int userId,int size, CancellationToken cancellationToken = default);
    }
}
