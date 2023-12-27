using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.User;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class UsersController : BaseCrudController<UserDto, IUsersService>
    {
        public UsersController(IUsersService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
