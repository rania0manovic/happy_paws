using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetBreed;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [ApiController]
    public class PetBreedsController : BaseCrudController<PetBreedDto, IPetBreedsService, PetBreedSearchObject>
    {
        public PetBreedsController(IPetBreedsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [HttpGet("GetBreedsForPetType")]
        public async Task<IActionResult> GetBreedsForPetType(int petTypeId, CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await Service.GetBreedsForPetTypeAsync(petTypeId, cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource with categoryID {0}", petTypeId);
                return BadRequest();
            }
        }
    }
}
