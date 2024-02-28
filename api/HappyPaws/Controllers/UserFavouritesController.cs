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
    }
}
