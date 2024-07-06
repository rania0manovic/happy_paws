using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetBreed;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [Authorize(Policy = "AllVerified")]
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
                Logger.LogError(e, "Problem when getting resource with pet type ID {PetTypeId}", petTypeId);
                return BadRequest();
            }
        }
        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Post([FromBody] PetBreedDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }
        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Put([FromBody] PetBreedDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Put(upsertDto, cancellationToken);
        }
        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Delete(int id, CancellationToken cancellationToken = default)
        {
            return base.Delete(id, cancellationToken);

        }

    }
}
