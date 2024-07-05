using FluentValidation;
using HappyPaws.Core.Dtos.EmailVerificationRequest;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class EmailVerificationRequestValidator : AbstractValidator<EmailVerificationRequestDto>
    {
        public EmailVerificationRequestValidator()
        {
            RuleFor(x => x.Code).NotNull();
            RuleFor(x => x.Email).NotEmpty().NotNull();

        }
    }
}
