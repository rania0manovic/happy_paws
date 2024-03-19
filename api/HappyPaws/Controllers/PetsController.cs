using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class PetsController : BaseCrudController<PetDto, IPetsService, PetSearchObject>
    {
        public PetsController(IPetsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        public override Task<IActionResult> Post([FromForm] PetDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }
        public override Task<IActionResult> Put([FromForm] PetDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Put(upsertDto, cancellationToken);
        }
    }
}
