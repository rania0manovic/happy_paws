using FluentValidation;
using HappyPaws.Core.Dtos.Product;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class ProductValidator : AbstractValidator<ProductDto>
    {
        public ProductValidator()
        {
            RuleFor(x => x.Name).NotNull().NotEmpty();
            RuleFor(x => x.UPC).NotNull().NotEmpty();
            RuleFor(x => x.Description).NotNull().NotEmpty();
            RuleFor(x => x.InStock).NotNull();
            RuleFor(x => x.Price).NotNull();
            RuleFor(x => x.BrandId).NotNull();
            RuleFor(x => x.ProductCategorySubcategoryId).NotNull();

        }
    }
}
