using FluentValidation;
using HappyPaws.Core.Dtos.ProductImage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class ProductImageValidator : AbstractValidator<ProductImageDto>
    {
        public ProductImageValidator()
        {

        }
    }
}
