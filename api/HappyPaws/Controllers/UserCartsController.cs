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
    }
}
