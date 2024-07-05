using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
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
            return await DbSet
                .Include(x => x.ProfilePhoto)
                .Where(x => searchObject.Role == x.Role && (searchObject.FullName == null
            || x.FirstName.ToLower().StartsWith(searchObject.FullName.ToLower())
            || x.LastName.ToLower().StartsWith(searchObject.FullName.ToLower()))
            && (searchObject.OnlySubscribers == false || x.IsSubscribed == true))
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

        public override Task<User?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            return DbSet.Include(x => x.ProfilePhoto).FirstOrDefaultAsync(x => x.Id == id, cancellationToken);
        }
        public async Task<int> GetCountByRoleAsync(Role role, CancellationToken cancellationToken = default)
        {
            return await DbSet.CountAsync(x => x.Role == role, cancellationToken);

        }
        public async Task<PagedList<User>> FindFreeEmployeesAsync(EmployeeSearchObject searchObject, CancellationToken cancellationToken)
        {
            var busyEmployees = DatabaseContext.Appointments
                .Where(a => searchObject.StartDateTime < a.EndDateTime && searchObject.EndDateTime > a.StartDateTime)
                .Select(a => a.EmployeeId)
                .Distinct();

            return await DbSet.Where(e => (e.EmployeePosition == EmployeePosition.Veterinarian ||
                            e.EmployeePosition == EmployeePosition.VeterinarianTechnician ||
                            e.EmployeePosition == EmployeePosition.VeterinarianAssistant ||
                            e.EmployeePosition == EmployeePosition.Groomer) &&
                            !busyEmployees.Contains(e.Id)).ToPagedListAsync(searchObject, cancellationToken);

        }
    }
}
