using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Allergy;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{

    public class AllergiesController : BaseCrudController<AllergyDto, IAllergiesService,AllergySearchObject>
    {
        public AllergiesController(IAllergiesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
