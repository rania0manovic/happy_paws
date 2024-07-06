using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.UserFavourite;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IUserFavouritesService : IBaseService<int, UserFavouriteDto, UserFavouriteSearchObject>
    {
        Task<PagedList<ProductDto>> GetPagedProductsAsync(UserFavouriteSearchObject searchObject, CancellationToken cancellationToken = default);
    }
}
