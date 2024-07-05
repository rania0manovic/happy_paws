using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [Route("/[controller]")]
    [ApiController]
    [Authorize]
    public abstract class BaseController : ControllerBase
    {
        protected readonly ILogger<BaseController> Logger;

        protected BaseController(ILogger<BaseController> logger)
        {
            Logger = logger;
        }
    }
}
