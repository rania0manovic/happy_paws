using FluentValidation;
using HappyPaws.Core.Dtos.UserCart;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class UserCartValidator : AbstractValidator<UserCartDto>
    {
        public UserCartValidator()
        {

        }
    }
}
