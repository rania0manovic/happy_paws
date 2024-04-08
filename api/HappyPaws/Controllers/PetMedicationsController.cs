using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetMedication;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{

    public class PetMedicationsController : BaseCrudController<PetMedicationDto, IPetMedicationsService, PetMedicationSearchObject>
    {
        public PetMedicationsController(IPetMedicationsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
