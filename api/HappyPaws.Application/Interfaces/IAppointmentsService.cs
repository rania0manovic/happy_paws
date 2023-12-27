using HappyPaws.Core.Dtos.Appointment;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IAppointmentsService : IBaseService<int, AppointmentDto>
    {
    }
}
