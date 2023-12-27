using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductSubcategory;
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
    public class ProductSubcategoriesService : BaseService<ProductSubcategory, ProductSubcategoryDto, IProductSubcategoriesRepository>, IProductSubcategoriesService
    {
        public ProductSubcategoriesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ProductSubcategoryDto> validator) : base(mapper, unitOfWork, validator)
        {
        }

        public override async Task<ProductSubcategoryDto> AddAsync(ProductSubcategoryDto dto, CancellationToken cancellationToken = default)
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
                await base.AddAsync(dto, cancellationToken);
                await UnitOfWork.CommitTransactionAsync(cancellationToken);
                return dto;

            }
            catch (Exception)
            {
                await UnitOfWork.RollbackTransactionAsync(cancellationToken);
                throw;
            }
        }

        public override async Task<ProductSubcategoryDto> UpdateAsync(ProductSubcategoryDto dto, CancellationToken cancellationToken = default)
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
    }
}
