using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.UserCart;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [Authorize(Roles = "User")]
    public class UserCartsController : BaseCrudController<UserCartDto, IUserCartsService, UserCartSearchObject>
    {
        private readonly CurrentUser _currentUser;
        public UserCartsController(IUserCartsService service, ILogger<BaseController> logger, CurrentUser currentUser) : base(service, logger)
        {
            _currentUser = currentUser;
        }

        [HttpGet("ProductAlreadyInCart")]
        public virtual async Task<IActionResult> ProductAlreadyInCart(int productId, CancellationToken cancellationToken = default)
        {
            try
            {
                var userId = _currentUser.Id;
                if (!userId.HasValue) return StatusCode(403);
                var dto = await Service.AlreadyInCartAsync(productId, userId.Value, cancellationToken);
                return Ok(dto);

            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource with Id {ProductId}", productId);
                return BadRequest();
            }
        }
    }
}
