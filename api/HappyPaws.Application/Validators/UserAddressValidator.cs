using FluentValidation;
using HappyPaws.Core.Dtos.Address;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class UserAddressValidator:AbstractValidator<UserAddressDto>
    {
        public UserAddressValidator()
        {
            RuleFor(x=>x.FullName).NotEmpty().NotNull();
        }
    }
}
