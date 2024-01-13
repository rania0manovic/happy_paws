using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.Dtos.ProductCategory;
using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace HappyPaws.Application.Services
{
    public class ProductCategoriesService : BaseService<ProductCategory, ProductCategoryDto, IProductCategoriesRepository>, IProductCategoriesService
    {
        public ProductCategoriesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ProductCategoryDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
        public override async Task<ProductCategoryDto> UpdateAsync(ProductCategoryDto dto, CancellationToken cancellationToken = default)
        {
            try
            {
                await UnitOfWork.BeginTransactionAsync(cancellationToken);
                if (dto.PhotoFile != null)
                {
                    var memoryStream = new MemoryStream();
                    await dto.PhotoFile.CopyToAsync(memoryStream, cancellationToken);

                    var photo = await UnitOfWork.ImagesRepository.GetByIdAsync(dto.PhotoId, cancellationToken);
                    photo!.ContentType = dto.PhotoFile.ContentType;
                    photo.Data = memoryStream.ToArray();
                    UnitOfWork.ImagesRepository.Update(photo);

                }
                var subcategoriesIds = await UnitOfWork.ProductCategorySubcategoriesRepository.GetSubcategoryIdsForCategoryAsync(dto.Id, cancellationToken, true);
                if (dto.RemovedSubcategoryIds != null)
                {
                    foreach (var subcategoryId in dto.RemovedSubcategoryIds)
                    {
                        await UnitOfWork.ProductCategorySubcategoriesRepository.RemoveBySubcategoryIdAsync(subcategoryId, cancellationToken);
                    }
                }
                if (dto.AddedSubcategoryIds != null)
                {
                    foreach (var subcategoryId in dto.AddedSubcategoryIds)
                    {
                        if (subcategoriesIds.Contains(subcategoryId))
                        {
                            await UnitOfWork.ProductCategorySubcategoriesRepository.AddBySubcategoryIdAsync(subcategoryId, cancellationToken);
                        }
                        else
                        {
                            ProductCategorySubcategory entity = new ProductCategorySubcategory()
                            {
                                ProductCategoryId = dto.Id,
                                ProductSubcategoryId = subcategoryId,
                            };
                            await UnitOfWork.ProductCategorySubcategoriesRepository.AddAsync(entity, cancellationToken);
                        }
                    }
                }
                await base.UpdateAsync(dto, cancellationToken);
                await UnitOfWork.SaveChangesAsync(cancellationToken);
                await UnitOfWork.CommitTransactionAsync(cancellationToken);
                return dto;

            }
            catch (Exception)
            {
                await UnitOfWork.RollbackTransactionAsync(cancellationToken);
                throw;
            }
        }
        public override async Task<ProductCategoryDto> AddAsync(ProductCategoryDto dto, CancellationToken cancellationToken = default)
        {

            try
            {
                await UnitOfWork.BeginTransactionAsync(cancellationToken);
                var memoryStream = new MemoryStream();
                await dto.PhotoFile.CopyToAsync(memoryStream, cancellationToken);
                var photo = new Image()
                {
                    ContentType = dto.PhotoFile.ContentType,
                    Data = memoryStream.ToArray(),
                };
                await UnitOfWork.ImagesRepository.AddAsync(photo, cancellationToken);
                await UnitOfWork.SaveChangesAsync(cancellationToken);
                dto.PhotoId = photo.Id;
                var productCategory = await base.AddAsync(dto, cancellationToken);
                await UnitOfWork.SaveChangesAsync(cancellationToken);
                if (dto.AddedSubcategoryIds != null)
                {
                    foreach (var subcategoryId in dto.AddedSubcategoryIds)
                    {
                        
                            ProductCategorySubcategory entity = new ProductCategorySubcategory()
                            {
                                ProductCategoryId = productCategory.Id,
                                ProductSubcategoryId = subcategoryId,
                            };
                            await UnitOfWork.ProductCategorySubcategoriesRepository.AddAsync(entity, cancellationToken);
                    }
                }
                await UnitOfWork.SaveChangesAsync(cancellationToken);
                await UnitOfWork.CommitTransactionAsync(cancellationToken);
                return dto;

            }
            catch (Exception)
            {
                await UnitOfWork.RollbackTransactionAsync(cancellationToken);
                throw;
            }


        }
    }
}
