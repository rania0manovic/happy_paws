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
    public class UserFavouritesRepository : BaseRepository<UserFavourite, int, UserFavouriteSearchObject>, IUserFavouritesRepository
    {
        public UserFavouritesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {

        }

        public async Task<PagedList<Product>> GetPagedProductsAsync(UserFavouriteSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x => x.Product).ThenInclude(x => x.ProductImages.Take(1)).ThenInclude(x => x.Image)
                .Where(x => x.UserId == searchObject.UserId).Select(x => x.Product).ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
