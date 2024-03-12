using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.UserFavourite;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class UserFavouritesController : BaseCrudController<UserFavouriteDto, IUserFavouritesService, UserFavouriteSearchObject>
    {
        public UserFavouritesController(IUserFavouritesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [HttpGet("GetPagedProducts")]
        public async Task<IActionResult> GetPagedProducts([FromQuery] UserFavouriteSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await Service.GetPagedProductsAsync(searchObject, cancellationToken);
                return Ok(dto);

            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource for userId {UserId}", searchObject.UserId);
                return BadRequest();
            }
        }
        
    }
}
