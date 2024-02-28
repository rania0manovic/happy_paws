using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace HappyPaws.Api.Controllers
{

    public abstract class BaseCrudController<TDto, TService, TSearchObject> : BaseController
        where TDto : BaseDto
        where TService : IBaseService<int, TDto, TSearchObject>
        where TSearchObject : BaseSearchObject
    {
        protected readonly TService Service;

        protected BaseCrudController(TService service, ILogger<BaseController> logger) : base(logger)
        {
            Service = service;
        }

        [HttpGet("{id}")]
        public virtual async Task<IActionResult> Get(int id, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await Service.GetByIdAsync(id, cancellationToken);
                return Ok(dto);

            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource with ID {0}", id);
                return BadRequest();
            }
        }

        [HttpGet("GetPaged")]
        public virtual async Task<IActionResult> GetPaged([FromQuery] TSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await Service.GetPagedAsync(searchObject, cancellationToken);
                return Ok(dto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting paged resources for page number {0}, with page size {1}", searchObject.PageNumber, searchObject.PageSize);
                return BadRequest();
            }
        }

        [HttpPost]
        public virtual async Task<IActionResult> Post([FromBody] TDto upsertDto, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await Service.AddAsync(upsertDto, cancellationToken);
                return Ok(dto);
            }
            catch (ValidationException e)
            {
                Logger.LogError(e, "Problem when updating resource");
                return BadRequest();
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when posting resource");
                return BadRequest();
            }
        }

        [HttpPut]
        public virtual async Task<IActionResult> Put([FromBody] TDto upsertDto, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await Service.UpdateAsync(upsertDto, cancellationToken);
                return Ok(dto);
            }
            catch (ValidationException e)
            {
                Logger.LogError(e, "Problem when updating resource");
                return BadRequest();
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when updating resource");
                return BadRequest();
            }
        }

        [HttpDelete("{id}")]
        public virtual async Task<IActionResult> Delete(int id, CancellationToken cancellationToken = default)
        {
            try
            {
                await Service.RemoveByIdAsync(id, cancellationToken);
                return Ok();
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when deleting resource");
                return BadRequest(e.Message);
            }
        }

    }
}
