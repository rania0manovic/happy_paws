using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Helpers;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.ProductImage;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class ProductsService : BaseService<Product, ProductDto, IProductsRepository, ProductSearchObject>, IProductsService
    {
        public ProductsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ProductDto> validator) : base(mapper, unitOfWork, validator)
        {
        }

        public override async Task<ProductDto> AddAsync(ProductDto dto, CancellationToken cancellationToken = default)
        {
            try
            {
                await UnitOfWork.BeginTransactionAsync(cancellationToken);
                var response = await base.AddAsync(dto, cancellationToken);
                foreach (var file in dto.ImageFiles)
                {
                    var memoryStream = new MemoryStream();
                    await file!.CopyToAsync(memoryStream, cancellationToken);
                    var optimizedImage = ImageSharp.OptimizeImage(memoryStream);
                    var image = new Image()
                    {
                        ContentType = file.ContentType,
                        Data = memoryStream.ToArray(),
                    };
                    await UnitOfWork.ImagesRepository.AddAsync(image, cancellationToken);
                    await UnitOfWork.SaveChangesAsync(cancellationToken);
                    var productImage = new ProductImage()
                    {
                        ProductId = response.Id,
                        ImageId = image.Id,
                    };
                    await UnitOfWork.ProductImagesRepository.AddAsync(productImage, cancellationToken);
                }
                await UnitOfWork.SaveChangesAsync(cancellationToken);
                await UnitOfWork.CommitTransactionAsync(cancellationToken);
                return response;

            }
            catch (Exception)
            {
                throw;
            }
        }
        public override async Task<ProductDto> UpdateAsync(ProductDto dto, CancellationToken cancellationToken = default)
        {
            try
            {
                await UnitOfWork.BeginTransactionAsync(cancellationToken);
                var response = await base.UpdateAsync(dto, cancellationToken);
                if(dto.ImageFiles != null)
                {
                    foreach (var file in dto.ImageFiles)
                    {
                        var memoryStream = new MemoryStream();
                        await file!.CopyToAsync(memoryStream, cancellationToken);
                        var optimizedImage = ImageSharp.OptimizeImage(memoryStream);
                        var image = new Image()
                        {
                            ContentType = file.ContentType,
                            Data = memoryStream.ToArray(),
                        };
                        await UnitOfWork.ImagesRepository.AddAsync(image, cancellationToken);
                        await UnitOfWork.SaveChangesAsync(cancellationToken);
                        var productImage = new ProductImage()
                        {
                            ProductId = response.Id,
                            ImageId = image.Id,
                        };
                        await UnitOfWork.ProductImagesRepository.AddAsync(productImage, cancellationToken);
                    }
                }
                await UnitOfWork.SaveChangesAsync(cancellationToken);
                await UnitOfWork.CommitTransactionAsync(cancellationToken);
                return response;

            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
