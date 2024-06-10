using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace HappyPaws.Api.Controllers
{
    public class PetsController : BaseCrudController<PetDto, IPetsService, PetSearchObject>
    {
        public PetsController(IPetsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        public override async Task<IActionResult> Post([FromForm] PetDto upsertDto, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await Service.AddAsync(upsertDto, cancellationToken);
                if (dto != null)
                {
                    dto = await Service.GetByIdAsync(dto.Id, cancellationToken);
                }
                else throw new Exception();
                return Ok(dto);
            }
            catch (ValidationException e)
            {
                Logger.LogError(e, "Validation error has occurred while posting resource");
                return BadRequest();
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when posting resource");
                return BadRequest();
            }
        }

        public override async Task<IActionResult> Put([FromForm] PetDto upsertDto, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await Service.UpdateAsync(upsertDto, cancellationToken);
                if (dto != null)
                {
                    dto = await Service.GetByIdAsync(dto.Id, cancellationToken);
                    if (dto != null)
                    {
                        return Ok(dto);
                    }
                    else throw new Exception();
                }
                else throw new Exception();
            }
            catch (ValidationException e)
            {
                Logger.LogError(e, "Validation error has occurred while updating resource");
                return BadRequest();
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when updating resource");
                return BadRequest();
            }
        }

        [HttpGet("HasAnyWithPetBreedId/{breedId}")]
        public async Task<IActionResult> HasAnyWithPetBreedId(int breedId, CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await Service.HasAnyWithPetBreedIdAsync(breedId, cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when checking for any products with pet breed id {breedId}!", breedId);
                return BadRequest();
            }
        }

        [HttpGet("HasAnyWithPetTypeId/{petTypeId}")]
        public async Task<IActionResult> HasAnyWithPetTypeId(int petTypeId, CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await Service.HasAnyWithPetTypeIdAsync(petTypeId, cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when checking for any products with pet type id {PetTypeId}!", petTypeId);
                return BadRequest();
            }
        }
    }
}
