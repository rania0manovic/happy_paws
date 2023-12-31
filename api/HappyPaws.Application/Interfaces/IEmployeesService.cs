﻿using HappyPaws.Core.Dtos.Employee;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IEmployeesService : IBaseService<int, EmployeeDto>
    {
    }
}
