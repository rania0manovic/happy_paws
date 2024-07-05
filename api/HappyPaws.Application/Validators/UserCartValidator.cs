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
            RuleFor(x => x.Quantity).NotNull();
            RuleFor(x => x.UserId).NotNull();
            RuleFor(x => x.ProductId).NotNull();

        }
    }
}
