using HappyPaws.Common.Services.EnumsService;
using HappyPaws.Infrastructure.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [AllowAnonymous]
    public class EnumsController : BaseController
    {
        private readonly IEnumsService _enumsService;
        public EnumsController(ILogger<BaseController> logger, IEnumsService enumsService) : base(logger)
        {
            _enumsService = enumsService;
        }
        [HttpGet("GetEmployeePositions")]
        public async Task<IActionResult> GetEmployeePositions(CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await _enumsService.GetEmployeePositionsAsync(cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when fetching enum EmployeePositions");
                return BadRequest(e.Message);
            }
        }
        [HttpGet("GetNewsletterTopics")]
        public async Task<IActionResult> GetNewsletterTopics(CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await _enumsService.GetNewsletterTopics(cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when fetching enum NewsletterTopics");
                return BadRequest(e.Message);
            }
        }
        [HttpGet("GetOrderStatuses")]
        public async Task<IActionResult> GetOrderStatuses(CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await _enumsService.GetOrderStatusesAsync(cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when fetching enum OrderStatuses");
                return BadRequest(e.Message);
            }
        }
    }
}
