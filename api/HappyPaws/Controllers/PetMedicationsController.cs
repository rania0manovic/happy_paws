using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetMedication;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [Authorize(Policy = "ClinicPolicy")]
    public class PetMedicationsController : BaseCrudController<PetMedicationDto, IPetMedicationsService, PetMedicationSearchObject>
    {
        public PetMedicationsController(IPetMedicationsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [Authorize]
        public override Task<IActionResult> GetPaged([FromQuery] PetMedicationSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return base.GetPaged(searchObject, cancellationToken);
        }
    }
}
