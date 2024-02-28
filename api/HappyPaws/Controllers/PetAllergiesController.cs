using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetAllergy;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class PetAllergiesController : BaseCrudController<PetAllergyDto, IPetAllergiesService, PetAllergySearchObject>
    {
        public PetAllergiesController(IPetAllergiesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
