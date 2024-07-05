using FluentValidation;
using HappyPaws.Core.Dtos.User;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class UserValidator : AbstractValidator<UserDto>
    {
        public UserValidator()
        {
            RuleFor(x => x.FirstName).NotNull().NotEmpty();
            RuleFor(x => x.LastName).NotNull().NotEmpty();
            RuleFor(x => x.Email).NotNull().NotEmpty();
            RuleFor(x => x.Gender).NotNull();
            RuleFor(x => x.Role).NotNull();
            RuleFor(x => x.IsVerified).NotNull();
            RuleFor(x => x.IsSubscribed).NotNull();
        }
    }
}
