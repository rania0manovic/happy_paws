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
            var result = DbSet.Include(x=>x.Product).ThenInclude(x => x.ProductImages).ThenInclude(x => x.Image)
                .Include(x => x.Product).ThenInclude(x => x.ProductReviews)
                .Where(x => x.UserId == searchObject.UserId)
                .Select(x => x.Product)
                .Where(x => searchObject.MinReview == null || x.ProductReviews.Average(x => x.Review) >= searchObject.MinReview).AsQueryable();

            if (searchObject.LowestPriceFirst != null)
            {
                if (searchObject.LowestPriceFirst == true)
                    result = result.OrderBy(x => x.Price);
                else
                    result = result.OrderByDescending(x => x.Price);
            }

            return await result.ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
