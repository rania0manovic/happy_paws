using FluentValidation;
using HappyPaws.Core.Dtos.Appointment;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class AppointmentValidator : AbstractValidator<AppointmentDto>
    {
        public AppointmentValidator()
        {
            RuleFor(x=>x.Reason).NotEmpty().NotNull();
            RuleFor(x=>x.PetId).NotNull();
        }
    }
}
