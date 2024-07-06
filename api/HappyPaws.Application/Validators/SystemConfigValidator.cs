using FluentValidation;
using HappyPaws.Core.Dtos.SystemConfig;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class SystemConfigValidator : AbstractValidator<SystemConfigDto>
    {
        public SystemConfigValidator()
        {
            RuleFor(x => x.DonationsGoal).NotNull();

        }
    }
}
