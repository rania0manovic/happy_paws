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
    public class AppointmentsRepository : BaseRepository<Appointment, int, AppointmentSearchObject>, IAppointmentsRepository
    {
        public AppointmentsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<Appointment>> GetPagedAsync(AppointmentSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x => x.Pet).ThenInclude(x => x.Owner)
                .Include(x=>x.Employee)
                .Where(x => (searchObject.UserId == null || x.Pet.OwnerId == searchObject.UserId) &&
                (searchObject.MinDateTime == null || x.StartDateTime> searchObject.MinDateTime) &&
                (searchObject.IsCancelled == null || x.IsCancelled==searchObject.IsCancelled) &&
                (searchObject.Date == null || x.StartDateTime.Value.Date == searchObject.Date.Value.Date))
                .OrderByDescending(x => x.CreatedAt)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
        public override async Task<Appointment?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            return await DbSet.AsNoTracking().FirstOrDefaultAsync(x => x.Id == id, cancellationToken: cancellationToken);
        }
    }
}
