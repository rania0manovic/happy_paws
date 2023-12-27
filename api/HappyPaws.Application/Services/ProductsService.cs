using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class ProductsService : BaseService<Product, ProductDto, IProductsRepository>, IProductsService
    {
        public ProductsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ProductDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
