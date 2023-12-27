using HappyPaws.Application.Interfaces;
using HappyPaws.Common.Services.AuthService;
using HappyPaws.Core.Dtos.EmailVerificationRequest;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Exceptions;
using HappyPaws.Infrastructure.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{

    public class AuthController : BaseController
    {
        private readonly IAuthService _authService;
        private readonly IUsersService _usersService;
        public AuthController(ILogger<BaseController> logger, IAuthService authService, IUsersService usersService) : base(logger)
        {
            _authService = authService;
            _usersService = usersService;
        }

        [HttpPost("SignIn")]
        public async Task<IActionResult> SignIn([FromBody] SignInModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await _authService.SignInAsync(model, cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when signing in user");
                return StatusCode(403);
            }
        }
        [HttpPost("SendEmailVerification")]
        public async Task<IActionResult> SendEmailVerification([FromBody] SignUpModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                var user = await _usersService.GetByEmailAsync(model.Email, cancellationToken);
                if (user == null)
                {
                    await _authService.SendEmailVerificationCodeAsync(model);
                    return Ok();
                }
                else
                    throw new UserWithSameEmailExistsException();

            }
            catch (UserWithSameEmailExistsException e)
            {
                Logger.LogError(e.Message, "User already exists with that email");
                return StatusCode(409, e.Message);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when signing up user");
                return BadRequest(e.Message);
            }
        }
        [HttpPost("SignUp")]
        public async Task<IActionResult> SignUp([FromBody] SignUpModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                var request = new EmailVerificationRequestDto() { Email = model.Email, Code = model.VerificationCode };
                var result = await _authService.VerifyEmail(request, cancellationToken);
                if (result)
                {
                    await _authService.SignUpAsync(model, cancellationToken);
                    return Ok();
                }
                else
                    return BadRequest();
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when signing up user");
                return BadRequest(e.Message);
            }
        }
    }
}
