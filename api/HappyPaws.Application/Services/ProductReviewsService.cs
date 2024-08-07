﻿using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductReview;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class ProductReviewsService : BaseService<ProductReview, ProductReviewDto, IProductReviewsRepository, ProductReviewSearchObject>, IProductReviewsService
    {
        public ProductReviewsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ProductReviewDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
