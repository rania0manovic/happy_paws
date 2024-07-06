using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Brand;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class BrandsService : BaseService<Brand, BrandDto, IBrandsRepository, BrandSearchObject>, IBrandsService
    {
        public BrandsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<BrandDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
