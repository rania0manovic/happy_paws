using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace HappyPaws.Api.Controllers
{
    public class PetsController : BaseCrudController<PetDto, IPetsService, PetSearchObject>
    {
        public PetsController(IPetsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [Authorize(Policy = "ClinicPolicy")]
        public override async Task<IActionResult> Post([FromBody] PetDto upsertDto, CancellationToken cancellationToken = default)
        {
            var dto = await Service.AddAsync(upsertDto, cancellationToken);
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
        [Authorize(Policy = "ClinicPolicy")]
        public override async Task<IActionResult> Put([FromBody] PetDto upsertDto, CancellationToken cancellationToken = default)
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
        [Authorize(Policy ="AllVerified")]
        public override Task<IActionResult> GetPaged([FromQuery] PetSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return base.GetPaged(searchObject, cancellationToken);
        }

        [Authorize(Policy = "AllVerified")]
        public override Task<IActionResult> Get(int id, CancellationToken cancellationToken = default)
        {
            return base.Get(id, cancellationToken);
        }

        [Authorize(Policy = "ClinicPolicy")]
        public override Task<IActionResult> Delete(int id, CancellationToken cancellationToken = default)
        {
            return base.Delete(id, cancellationToken);
        }

        [Authorize(Roles = "Admin")]
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

        [Authorize(Roles = "Admin")]
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
