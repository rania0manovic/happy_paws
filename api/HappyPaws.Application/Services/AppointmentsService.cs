using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Appointment;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Services
{
    public class AppointmentsService : BaseService<Appointment, AppointmentDto, IAppointmentsRepository, AppointmentSearchObject>, IAppointmentsService
    {
        public AppointmentsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<AppointmentDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
        public async Task<bool> IsValidTime(AppointmentSearchObject searchObject)
        {
            DateTime startWorkingTime = searchObject.Date.Value.AddHours(8);
            DateTime endWorkingTime = searchObject.Date.Value.AddHours(16);
            if (searchObject.StartDateTime < startWorkingTime || searchObject.EndDateTime > endWorkingTime)
            {
                return false;
            }
            List<TimeSlots> availableTimeSlots = new();
            var appointments = await CurrentRepository.GetPagedAsync(searchObject);
            appointments.Items.Sort((a, b) => a.StartDateTime.HasValue.CompareTo(b.StartDateTime.HasValue));
            if (appointments.Items.Count == 0)
            {
                return true;
            }

            DateTime currentTime = startWorkingTime;
            foreach (var appointment in appointments.Items)
            {
                if (currentTime <= appointment.StartDateTime)
                {
                    availableTimeSlots.Add(new TimeSlots { StartTime=currentTime,EndTime= (DateTime)appointment.StartDateTime });
                }

                currentTime = (DateTime)appointment.EndDateTime;
                if(currentTime <= endWorkingTime)
                {
                    availableTimeSlots.Add(new TimeSlots { StartTime = currentTime, EndTime = endWorkingTime });
                }
            }
            foreach(var item in availableTimeSlots)
            {
                if (searchObject.StartDateTime.Value.Hour >= item.StartTime.Hour && searchObject.EndDateTime.Value.Hour <= item.EndTime.Hour)
                    return true;
            }


            return false;
        }
    }
}
