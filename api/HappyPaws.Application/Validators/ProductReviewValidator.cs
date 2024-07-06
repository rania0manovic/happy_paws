using FluentValidation;
using HappyPaws.Core.Dtos.ProductReview;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class ProductReviewValidator : AbstractValidator<ProductReviewDto>
    {
        public ProductReviewValidator()
        {
            RuleFor(x => x.Review).NotNull();
            RuleFor(x => x.ProductId).NotNull();
            RuleFor(x => x.ReviewerId).NotNull();

        }
    }
}
