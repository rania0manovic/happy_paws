using FluentValidation;
using HappyPaws.Core.Dtos.ProductSubcategory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class ProductSubcategoryValidator : AbstractValidator<ProductSubcategoryDto>
    {
        public ProductSubcategoryValidator()
        {

        }
    }
}
