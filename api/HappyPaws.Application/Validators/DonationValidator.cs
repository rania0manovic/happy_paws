﻿using FluentValidation;
using HappyPaws.Core.Dtos.Donation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class DonationValidator : AbstractValidator<DonationDto>
    {
        public DonationValidator()
        {
            RuleFor(x => x.Amount).NotNull();
            RuleFor(x => x.UserId).NotNull();
        }
    }
}
