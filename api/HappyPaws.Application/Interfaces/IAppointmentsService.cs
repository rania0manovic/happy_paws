﻿using HappyPaws.Core.Dtos.Appointment;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IAppointmentsService : IBaseService<int, AppointmentDto, AppointmentSearchObject>
    {
        Task<bool> IsValidTime(AppointmentSearchObject searchObject);

    }
}
