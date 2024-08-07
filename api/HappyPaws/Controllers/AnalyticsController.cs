﻿using HappyPaws.Api.HostedServices.Kafka;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Helpers;
using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.Dtos.ProductCategory;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;

namespace HappyPaws.Api.Controllers
{
    public class AnalyticsController : BaseController
    {
        protected readonly IUsersService _usersService;
        protected readonly IPetsService _petsService;
        protected readonly IOrdersService _ordersService;
        protected readonly IDonationsService _donationsService;
        private readonly IMemoryCache _memoryCache;
        public AnalyticsController(ILogger<BaseController> logger, IUsersService usersService, IPetsService petsService, IOrdersService ordersService, IMemoryCache memoryCache, IDonationsService donationsService) : base(logger)
        {
            _usersService = usersService;
            _petsService = petsService;
            _ordersService = ordersService;
            _memoryCache = memoryCache;
            _donationsService = donationsService;
        }
        [Authorize(Roles = "Admin")]
        [HttpGet]
        public async Task<IActionResult> GetAnalytics(bool refresh=false, CancellationToken cancellationToken = default)
        {
            try
            {
                if (!refresh && _memoryCache.TryGetValue<AnalyticsDto>("analytics", out var analytics))
                {
                    return Ok(analytics);
                }
                var appUsers = await _usersService.GetCountByRoleAsync(Role.User, cancellationToken);
                var employees = await _usersService.GetCountByRoleAsync(Role.Employee, cancellationToken);
                var patients = await _petsService.GetCountAsync(cancellationToken);
                var monthlyIncome = await _ordersService.GetIncomeForMonthAsync(DateTime.Now.Month, cancellationToken);
                var totalIncome = await _ordersService.GetIncomeForMonthAsync(0, cancellationToken);
                var monthlyDonations = await _donationsService.GetAmountForMonthAsync(DateTime.Now.Month, cancellationToken);
                var response = new AnalyticsDto()
                {
                    AppUsersCount = appUsers,
                    EmployeesCount = employees,
                    PatientsCount = patients,
                    MonthlyIncome = monthlyIncome,
                    MonthlyDonations = monthlyDonations,
                    IncomeTotal = totalIncome,
                };
                _memoryCache.Set("analytics", response, TimeSpan.FromDays(1));
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting dashboard analytics");

                return BadRequest();
            }
        }
        [Authorize(Roles = "Admin")]
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
