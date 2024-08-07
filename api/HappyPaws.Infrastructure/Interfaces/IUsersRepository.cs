﻿using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Interfaces
{
    public interface IUsersRepository : IBaseRepository<User, int, UserSearchObject>
    {
        Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default);
        Task<string?> GetConnectionId(int userId, CancellationToken cancellationToken = default);
        Task<int> GetCountByRoleAsync(Role role, CancellationToken cancellationToken = default);
        Task<PagedList<User>> FindFreeEmployeesAsync(EmployeeSearchObject searchObject, CancellationToken cancellationToken);

    }
}
