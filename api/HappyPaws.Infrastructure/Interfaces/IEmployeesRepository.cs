﻿using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Interfaces
{
    public interface IEmployeesRepository : IBaseRepository<Employee, int, EmployeeSearchObject>
    {
        Task<PagedList<Employee>> FindFreeEmployeesAsync(EmployeeSearchObject searchObject, CancellationToken cancellationToken);
    }
}
