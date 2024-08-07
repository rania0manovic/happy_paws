﻿using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductImage;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class ProductImagesService : BaseService<ProductImage, ProductImageDto, IProductImagesRepository, BaseSearchObject>, IProductImageService
    {
        public ProductImagesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ProductImageDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
