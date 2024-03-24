using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Employee;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class EmployeesController : BaseCrudController<EmployeeDto, IEmployeesService, EmployeeSearchObject>
    {
        public EmployeesController(IEmployeesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        public override Task<IActionResult> Post([FromForm] EmployeeDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }
        public override Task<IActionResult> Put([FromForm] EmployeeDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Put(upsertDto, cancellationToken);
        }
        [HttpGet("FreeEmployees")]
        public virtual async Task<IActionResult> FreeEmployees([FromQuery] EmployeeSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            try
            {
                if (!(searchObject.Date.HasValue && searchObject.StartDateTime.HasValue && searchObject.EndDateTime.HasValue))
                    throw new Exception("One or more DateTime params are null!");
                searchObject.StartDateTime = searchObject.Date.Value.AddHours(searchObject.StartDateTime.Value.Hour).AddMinutes(searchObject.StartDateTime.Value.Minute);
                searchObject.EndDateTime = searchObject.Date.Value.AddHours(searchObject.EndDateTime.Value.Hour).AddMinutes(searchObject.EndDateTime.Value.Minute);
                var result = await Service.FindFreeEmployeesAsync(searchObject, cancellationToken);
                if (result.TotalCount == 0)
                    return StatusCode(StatusCodes.Status406NotAcceptable);
                else return Ok(result);

            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resources!");
                return BadRequest();
            }
        }
    }
}
