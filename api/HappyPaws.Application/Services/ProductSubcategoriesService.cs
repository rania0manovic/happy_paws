using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductSubcategory;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Services
{
    public class ProductSubcategoriesService : BaseService<ProductSubcategory, ProductSubcategoryDto, IProductSubcategoriesRepository, ProductSubcategorySearchObject>, IProductSubcategoriesService
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
                if (dto.DownloadURL != null)
                {
                    var photo = new Image()
                    {
                        DownloadURL = dto.DownloadURL,
                    };
                    await UnitOfWork.ImagesRepository.AddAsync(photo, cancellationToken);
                    await UnitOfWork.SaveChangesAsync(cancellationToken);
                    dto.PhotoId = photo.Id;
                }
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
                if (dto.DownloadURL != null)
                {
                    dynamic photo;
                    if (dto.PhotoId != null && dto.Photo!=null)
                    {
                        dto.Photo.DownloadURL = dto.DownloadURL;
                    }
                    else
                    {
                        photo = new Image()
                        {
                            DownloadURL = dto.DownloadURL,
                        };
                        await UnitOfWork.ImagesRepository.AddAsync(photo, cancellationToken);
                        await UnitOfWork.SaveChangesAsync(cancellationToken);
                        dto.PhotoId = photo.Id;
                        dto.Photo = photo;

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
    }
}
