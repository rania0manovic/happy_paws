using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetAllergy;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [Authorize(Policy = "AllVerified")]
    public class PetAllergiesController : BaseCrudController<PetAllergyDto, IPetAllergiesService, PetAllergySearchObject>
    {
        public PetAllergiesController(IPetAllergiesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [Authorize]
        public override Task<IActionResult> GetPaged([FromQuery] PetAllergySearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return base.GetPaged(searchObject, cancellationToken);
        }

    }
}
