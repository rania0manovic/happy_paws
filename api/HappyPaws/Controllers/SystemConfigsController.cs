using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.SystemConfig;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class SystemConfigsController : BaseCrudController<SystemConfigDto, ISystemConfigsService, SystemConfigSearchObject>
    {
        public SystemConfigsController(ISystemConfigsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
       
    }
}
