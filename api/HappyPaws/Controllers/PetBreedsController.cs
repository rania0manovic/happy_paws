using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetBreed;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PetBreedsController : BaseCrudController<PetBreedDto, IPetBreedsService>
    {
        public PetBreedsController(IPetBreedsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
