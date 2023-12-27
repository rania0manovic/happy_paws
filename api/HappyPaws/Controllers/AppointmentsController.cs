using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Appointment;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class AppointmentsController : BaseCrudController<AppointmentDto, IAppointmentsService>
    {
        public AppointmentsController(IAppointmentsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
