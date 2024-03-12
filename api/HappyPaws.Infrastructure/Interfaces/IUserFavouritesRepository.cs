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
    public interface IUserFavouritesRepository : IBaseRepository<UserFavourite, int, UserFavouriteSearchObject>
    {
        Task<PagedList<Product>> GetPagedProductsAsync(UserFavouriteSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<UserFavourite> IsAlreadyStored(int productId, int userId, CancellationToken cancellationToken = default);

    }
}
