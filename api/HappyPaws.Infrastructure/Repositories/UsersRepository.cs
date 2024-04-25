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
    public class UsersRepository : BaseRepository<User, int, UserSearchObject>, IUsersRepository
    {
        public UsersRepository(DatabaseContext databaseContext) : base(databaseContext)
        {

        }
        public override async Task<PagedList<User>> GetPagedAsync(UserSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x => searchObject.FullName == null
            || (x.FirstName.ToLower().StartsWith(searchObject.FullName.ToLower())
            || x.LastName.ToLower().StartsWith(searchObject.FullName.ToLower())))
                .ToPagedListAsync(searchObject, cancellationToken);
        }
        public async Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default)
        {
            return await DbSet.AsNoTracking().FirstOrDefaultAsync(x => x.Email == email, cancellationToken);

        }

        public async Task<string?> GetConnectionId(int userId, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x => x.Id == userId)
                .Select(x => x.ConnectionId)
                .FirstOrDefaultAsync(cancellationToken);
        }
    }
}
