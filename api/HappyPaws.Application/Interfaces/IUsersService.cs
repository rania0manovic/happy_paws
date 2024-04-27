using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Enums;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IUsersService : IBaseService<int, UserDto, UserSearchObject>
    {
        Task<UserSensitiveDto> GetByEmailAsync(string email, CancellationToken cancellationToken = default);
        Task<string?> GetConnectionId(int userId, CancellationToken cancellationToken = default);
        Task<int> GetCountByRoleAsync(Role role, CancellationToken cancellationToken = default);
    }
}
