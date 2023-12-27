using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.UserFavourite;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class UserFavouritesController : BaseCrudController<UserFavouriteDto, IUserFavouritesService>
    {
        public UserFavouritesController(IUserFavouritesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
