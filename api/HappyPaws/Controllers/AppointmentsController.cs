﻿using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Appointment;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class AppointmentsController : BaseCrudController<AppointmentDto, IAppointmentsService, AppointmentSearchObject>
    {
        public AppointmentsController(IAppointmentsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [HttpGet("BookAppointment")]
        public virtual async Task<IActionResult> BookAppointment([FromQuery] AppointmentSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            try
            {
                if (!(searchObject.Date.HasValue && searchObject.StartDateTime.HasValue && searchObject.EndDateTime.HasValue))
                    throw new Exception("One or more DateTime params are null!");
                searchObject.StartDateTime = searchObject.Date.Value.AddHours(searchObject.StartDateTime.Value.Hour).AddMinutes(searchObject.StartDateTime.Value.Minute);
                searchObject.EndDateTime = searchObject.Date.Value.AddHours(searchObject.EndDateTime.Value.Hour).AddMinutes(searchObject.EndDateTime.Value.Minute);
                if (searchObject.AppointmentId == null) throw new Exception("Appointment Id was null!");
                var appointment = await Service.GetByIdAsync((int)searchObject.AppointmentId, cancellationToken) ?? throw new Exception($"Exception with Id {searchObject.AppointmentId} does not exist!");
                appointment.EmployeeId = searchObject.EmployeeId;
                appointment.StartDateTime = searchObject.StartDateTime;
                appointment.EndDateTime = searchObject.EndDateTime;
                await Service.UpdateAsync(appointment, cancellationToken);
                return Ok();


            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resources!");
                return BadRequest();
            }
        }
    }
}
