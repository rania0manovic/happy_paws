using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class UsersController : BaseCrudController<UserDto, IUsersService, UserSearchObject>
    {
        public UsersController(IUsersService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
