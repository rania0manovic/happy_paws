using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Helpers;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class AnalyticsController : BaseController
    {
        protected readonly IUsersService _usersService;
        protected readonly IPetsService _petsService;
        public AnalyticsController(ILogger<BaseController> logger, IUsersService usersService, IPetsService petsService) : base(logger)
        {
            _usersService = usersService;
            _petsService = petsService;
        }
        [HttpGet]
        public async Task<IActionResult> GetAnalytics(CancellationToken cancellationToken = default)
        {
            try
            {
                var appUsers = await _usersService.GetCountByRoleAsync(Role.User, cancellationToken);
                var employees = await _usersService.GetCountByRoleAsync(Role.Employee, cancellationToken);
                var patients = await _petsService.GetCountAsync(cancellationToken);
                var response = new AnalyticsDto()
                {
                    AppUsersCount = appUsers,
                    EmployeesCount = employees,
                    PatientsCount = patients
                };
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting dashboard analytics");

                return BadRequest();
            }
        }
        [HttpGet("GetCountByPetType")]
        public async Task<IActionResult> GetCountByPetType(CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await _petsService.GetCountByPetTypeAsync(cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting dashboard analytics for bar chart");

                return BadRequest();
            }
        }

    }
}
