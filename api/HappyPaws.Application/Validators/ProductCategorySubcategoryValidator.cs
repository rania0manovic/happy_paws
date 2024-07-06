using FluentValidation;
using HappyPaws.Core.Dtos.ProductCategorySubcategory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class ProductCategorySubcategoryValidator : AbstractValidator<ProductCategorySubcategoryDto>
    {
        public ProductCategorySubcategoryValidator()
        {
            RuleFor(x => x.ProductSubcategoryId).NotNull();
            RuleFor(x => x.ProductCategoryId).NotNull();

        }
    }
}
