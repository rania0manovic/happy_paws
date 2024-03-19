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
    public class UserCartsRepository : BaseRepository<UserCart, int, UserCartSearchObject>, IUserCartsRepository
    {
        public UserCartsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<UserCart>> GetPagedAsync(UserCartSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet
                .Include(x => x.Product).ThenInclude(x => x.ProductImages.Take(1)).ThenInclude(x => x.Image)
                .Include(x => x.Product).ThenInclude(x => x.Brand)
                .Where(x => x.UserId == searchObject.UserId).ToPagedListAsync(searchObject, cancellationToken);
        }
        public override async Task<UserCart?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            return await DbSet.AsNoTracking().FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

        }

        public async Task<bool> AlreadyInCartAsync(int productId, CancellationToken cancellationToken = default)
        {
            return await DbSet.AnyAsync(x => x.ProductId == productId, cancellationToken);
        }
    }
}
