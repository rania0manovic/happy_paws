using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Appointment;
using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Services
{
    public class AppointmentsService : BaseService<Appointment, AppointmentDto, IAppointmentsRepository>, IAppointmentsService
    {
        public AppointmentsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<AppointmentDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
