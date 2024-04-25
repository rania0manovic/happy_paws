using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Api.Hubs.MessageHub;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Appointment;
using HappyPaws.Core.Dtos.Notification;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;

namespace HappyPaws.Api.Controllers
{
    public class AppointmentsController : BaseCrudController<AppointmentDto, IAppointmentsService, AppointmentSearchObject>
    {
        private readonly IHubContext<MessageHub> _hubContext;
        private readonly IUsersService _usersService;
        private readonly INotificationsService _notificationsService;
        public AppointmentsController(IAppointmentsService service, ILogger<BaseController> logger, IHubContext<MessageHub> hubContext, IUsersService usersService, INotificationsService notificationsService) : base(service, logger)
        {
            _hubContext = hubContext;
            _usersService = usersService;
            _notificationsService = notificationsService;
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
                var notification = new NotificationDto
                {
                    Message = "Your appointment for pet " + appointment.Pet.Name + " has been booked!",
                    Title = "Appointment confirmation",
                    UserId = appointment.Pet.OwnerId,
                };
                appointment.EmployeeId = searchObject.EmployeeId;
                appointment.StartDateTime = searchObject.StartDateTime;
                appointment.EndDateTime = searchObject.EndDateTime;
                var response = await Service.UpdateAsync(appointment, cancellationToken);
                if (response != null)
                {
                    var connectionId = await _usersService.GetConnectionId(notification.UserId, cancellationToken);
                    var notificationResponse = await _notificationsService.AddAsync(notification, cancellationToken);
                    if (connectionId != null)
                    {
                        await _hubContext.Clients.Client(connectionId).SendAsync("NewNotification", notificationResponse, cancellationToken: cancellationToken);
                    }
                }
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
