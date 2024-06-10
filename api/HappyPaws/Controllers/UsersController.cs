using HappyPaws.Api.Auth.AuthService;
using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Application.Interfaces;
using HappyPaws.Common.Services.AuthService;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;

namespace HappyPaws.Api.Controllers
{
    public class UsersController : BaseCrudController<UserDto, IUsersService, UserSearchObject>
    {
        readonly IAuthService _authService;
        private readonly CurrentUser _currentUser;
        private readonly IMemoryCache _memoryCache;
        public UsersController(IUsersService service, ILogger<BaseController> logger, IAuthService authService, CurrentUser currentUser, IMemoryCache memoryCache) : base(service, logger)
        {
            _authService = authService;
            _currentUser = currentUser;
            _memoryCache = memoryCache;
        }
        public override async Task<IActionResult> Post([FromForm] UserDto upsertDto, CancellationToken cancellationToken = default)
        {
            return await base.Post(upsertDto, cancellationToken);
        }
        public override async Task<IActionResult> Put([FromForm] UserDto upsertDto, CancellationToken cancellationToken = default)
        {
            try
            {
                dynamic response;
                if (upsertDto.Role == 0)
                    response = await _authService.UpdateUserAsync(upsertDto, cancellationToken);
                else if (upsertDto.Role == Core.Enums.Role.Employee)
                    response = await base.Put(upsertDto, cancellationToken);
                else throw new UnauthorizedAccessException();
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when updating user with Id: {Id}", upsertDto.Id);
                return StatusCode(403);
            }
        }
        [HttpGet("FreeEmployees")]
        public virtual async Task<IActionResult> FreeEmployees([FromQuery] EmployeeSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            try
            {
                if (!(searchObject.Date.HasValue && searchObject.StartDateTime.HasValue && searchObject.EndDateTime.HasValue))
                    throw new Exception("One or more DateTime params are null!");
                searchObject.StartDateTime = searchObject.Date.Value.AddHours(searchObject.StartDateTime.Value.Hour).AddMinutes(searchObject.StartDateTime.Value.Minute);
                searchObject.EndDateTime = searchObject.Date.Value.AddHours(searchObject.EndDateTime.Value.Hour).AddMinutes(searchObject.EndDateTime.Value.Minute);
                var result = await Service.FindFreeEmployeesAsync(searchObject, cancellationToken);
                if (result.TotalCount == 0)
                    return StatusCode(StatusCodes.Status406NotAcceptable);
                else return Ok(result);

            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resources!");
                return BadRequest();
            }
        }
        [HttpGet("RecommendedProducts")]
        public virtual async Task<IActionResult> RecommendedProducts(CancellationToken cancellationToken = default)
        {
            try
            {
                var userId = _currentUser.Id;
                if (!userId.HasValue) return StatusCode(403);
                string cacheKey = $"RecommendedProducts_{userId.Value}";
                if (_memoryCache.TryGetValue<List<ProductDto>>(cacheKey, out var recommendedProducts))
                {
                    return Ok(recommendedProducts);
                }
                var result = await Service.GetRecommendedProductsForUser((int)userId, cancellationToken);
                _memoryCache.Set(cacheKey, result, TimeSpan.FromHours(1));
                return Ok(result);

            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resources!");
                return BadRequest();
            }
        }
    }
}