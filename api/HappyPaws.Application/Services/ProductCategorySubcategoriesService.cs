using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductCategorySubcategory;
using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Services
{
    public class ProductCategorySubcategoriesService : BaseService<ProductCategorySubcategory, ProductCategorySubcategoryDto, IProductCategorySubcategoriesRepository>, IProductCategorySubcategoriesService
    {
        public ProductCategorySubcategoriesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ProductCategorySubcategoryDto> validator) : base(mapper, unitOfWork, validator)
        {
        }

        public async Task<List<int>> GetSubcategoryIdsForCategoryAsync(int categoryId, CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.GetSubcategoryIdsForCategory(categoryId, cancellationToken);
        }
    }
}
