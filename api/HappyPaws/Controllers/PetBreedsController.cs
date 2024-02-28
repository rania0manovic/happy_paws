using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetBreed;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PetBreedsController : BaseCrudController<PetBreedDto, IPetBreedsService, PetBreedSearchObject>
    {
        public PetBreedsController(IPetBreedsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
