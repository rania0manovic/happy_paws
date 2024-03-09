using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.UserCart;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class UserCartsController : BaseCrudController<UserCartDto, IUserCartsService, UserCartSearchObject>
    {
        public UserCartsController(IUserCartsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [HttpGet("ProductAlreadyInCart")]
        public virtual async Task<IActionResult> ProductAlreadyInCart(int productId, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await Service.AlreadyInCartAsync(productId, cancellationToken);
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
