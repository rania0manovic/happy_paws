using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetType;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [Authorize(Policy = "AllVerified")]
    public class PetTypesController : BaseCrudController<PetTypeDto, IPetTypesService, PetTypeSearchObject>
    {
        public PetTypesController(IPetTypesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Post([FromBody] PetTypeDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }

        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Put([FromBody] PetTypeDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Put(upsertDto, cancellationToken);
        }

        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Delete(int id, CancellationToken cancellationToken = default)
        {
            return base.Delete(id, cancellationToken);
        }
    }
}
