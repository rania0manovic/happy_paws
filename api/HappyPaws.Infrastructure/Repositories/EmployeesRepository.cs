using HappyPaws.Core.Dtos.Employee;
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
    public class EmployeesRepository : BaseRepository<Employee, int, EmployeeSearchObject>, IEmployeesRepository
    {
        public EmployeesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<Employee>> GetPagedAsync(EmployeeSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x => searchObject.ClinicOnly == null ||
            (x.EmployeePosition == Core.Enums.EmployeePosition.VeterinarianTechnician ||
            x.EmployeePosition == Core.Enums.EmployeePosition.Veterinarian ||
            x.EmployeePosition == Core.Enums.EmployeePosition.VeterinarianAssistant ||
            x.EmployeePosition == Core.Enums.EmployeePosition.Groomer))
                .Include(x => x.ProfilePhoto).ToPagedListAsync(searchObject, cancellationToken);
        }
        public async Task<PagedList<Employee>> FindFreeEmployeesAsync(EmployeeSearchObject searchObject, CancellationToken cancellationToken)
        {
            var busyEmployees = DatabaseContext.Appointments
                .Where(a => searchObject.StartDateTime < a.EndDateTime && searchObject.EndDateTime > a.StartDateTime)
                .Select(a => a.EmployeeId)
                .Distinct();

            return await DbSet.Where(e => !busyEmployees.Contains(e.Id)).ToPagedListAsync(searchObject,cancellationToken);

        }
    }
}
