using HappyPaws.Api.Auth.AuthService;
using HappyPaws.Application.Interfaces;
using HappyPaws.Common.Services.AuthService;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class UsersController : BaseCrudController<UserDto, IUsersService, UserSearchObject>
    {
        readonly IAuthService _authService;
        public UsersController(IUsersService service, ILogger<BaseController> logger, IAuthService authService) : base(service, logger)
        {
            _authService = authService;
        }

        public override async Task<IActionResult> Put([FromForm] UserDto upsertDto, CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await _authService.UpdateUserAsync(upsertDto, cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when updating user with Id: {Id}", upsertDto.Id);
                return StatusCode(403);
            }
        }
    }
}
