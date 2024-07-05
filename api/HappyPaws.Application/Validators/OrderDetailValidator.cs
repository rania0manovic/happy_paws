using FluentValidation;
using HappyPaws.Core.Dtos.OrderDetail;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class OrderDetailValidator : AbstractValidator<OrderDetailDto>
    {
        public OrderDetailValidator()
        {
            RuleFor(x => x.Quantity).NotNull();
            RuleFor(x => x.UnitPrice).NotNull();
            RuleFor(x => x.OrderId).NotNull();
            RuleFor(x => x.ProductId).NotNull();

        }
    }
}
