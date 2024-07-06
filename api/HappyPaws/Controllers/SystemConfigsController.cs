using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.SystemConfig;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class SystemConfigsController : BaseCrudController<SystemConfigDto, ISystemConfigsService, SystemConfigSearchObject>
    {
        public SystemConfigsController(ISystemConfigsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Put([FromBody] SystemConfigDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Put(upsertDto, cancellationToken);
        }
        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Get(int id, CancellationToken cancellationToken = default)
        {
            return base.Get(id, cancellationToken);
        }
    }
}
