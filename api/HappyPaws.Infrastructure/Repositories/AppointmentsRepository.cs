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
            return await DbSet.Include(x => x.Pet)
                .Where(x => searchObject.UserId == null || x.Pet.OwnerId == searchObject.UserId)
                .OrderBy(x => x.DateTime)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
