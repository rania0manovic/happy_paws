using HappyPaws.Api.Auth.CurrentUserClaims;
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
        private readonly CurrentUser _currentUser;
        public AuthController(ILogger<BaseController> logger, IAuthService authService, IUsersService usersService, CurrentUser currentUser) : base(logger)
        {
            _authService = authService;
            _usersService = usersService;
            _currentUser = currentUser;
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
                    await _authService.SendEmailVerificationCodeAsync(model, cancellationToken);
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

        [HttpPut("UpdatePassword")]
        public async Task<IActionResult> UpdatePassword([FromBody] ChangePasswordModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                await _authService.UpdatePasswordAsync(model, cancellationToken);
                return Ok();
            }
            catch (UserWrongCredentialsException e)
            {
                Logger.LogError(e, "User wrong credentials exception.");
                return StatusCode(403);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Error when updating password");
                return BadRequest();
            }
        }
    }
}
