using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Allergy;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{

    public class AllergiesController : BaseCrudController<AllergyDto, IAllergiesService>
    {
        public AllergiesController(IAllergiesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
