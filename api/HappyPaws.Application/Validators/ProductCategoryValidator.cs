using FluentValidation;
using HappyPaws.Core.Dtos.ProductCategory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class ProductCategoryValidator : AbstractValidator<ProductCategoryDto>
    {
        public ProductCategoryValidator()
        {
            RuleFor(x => x.Name).NotNull().NotEmpty();
            RuleFor(x => x.PhotoId).NotNull();

        }
    }
}
