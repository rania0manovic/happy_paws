using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Helpers;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.ProductImage;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Linq;
using System.Threading;

namespace HappyPaws.Application.Services
{
    public class ProductsService : BaseService<Product, ProductDto, IProductsRepository, ProductSearchObject>, IProductsService
    {
        private readonly IUserFavouritesService _userFavouritesService;
        public ProductsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ProductDto> validator, IUserFavouritesService userFavouritesService) : base(mapper, unitOfWork, validator)
        {
            _userFavouritesService = userFavouritesService;
        }

        public override async Task<ProductDto> AddAsync(ProductDto dto, CancellationToken cancellationToken = default)
        {
            try
            {
                await UnitOfWork.BeginTransactionAsync(cancellationToken);
                var response = await base.AddAsync(dto, cancellationToken);
                if (dto.DownloadURLs != null)
                {
                    foreach (var url in dto.DownloadURLs)
                    {
                        var image = new Image()
                        {
                            DownloadURL = url
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
        public override async Task<ProductDto> UpdateAsync(ProductDto dto, CancellationToken cancellationToken = default)
        {
            try
            {
                await UnitOfWork.BeginTransactionAsync(cancellationToken);
                var response = await base.UpdateAsync(dto, cancellationToken);
                if (dto.DownloadURLs != null)
                {
                    foreach (var url in dto.DownloadURLs)
                    {
                        var image = new Image()
                        {
                            DownloadURL = url
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
        public override async Task<PagedList<ProductDto>> GetPagedAsync(ProductSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var response = Mapper.Map<PagedList<ProductDto>>(await CurrentRepository.GetPagedAsync(searchObject, cancellationToken));
            if (searchObject.GetReviews)
            {
                foreach (var item in response.Items)
                {
                    if (item != null && item.ProductReviews != null && item.ProductReviews.Count > 0)
                    {
                        item.Review = (int)item.ProductReviews.Average(x => x.Review);
                    }
                }
              
            }
            return response;
        }
        public async Task<ProductDto?> GetByIdAsync(int id, int userId, CancellationToken cancellationToken = default)
        {
            var result = Mapper.Map<ProductDto>(await CurrentRepository.GetByIdAsync(id, userId, cancellationToken));
            if (result != null)
            {
                if (!result.UserFavouriteItems.IsNullOrEmpty())
                    result.IsFavourite = true;
                if (!result.ProductReviews.IsNullOrEmpty())
                {
                    result.Review = (int)result.ProductReviews.Average(x => x.Review);
                }

            }

            return result;
        }



        public async Task<List<ProductDto>> GetBestsellersAsync(int size, CancellationToken cancellationToken = default)
        {
            return Mapper.Map<List<ProductDto>>(await CurrentRepository.GetBestsellersAsync(size, cancellationToken));
        }

        public async Task UpdateStockAsync(int id, int size, CancellationToken cancellation = default)
        {
            await CurrentRepository.UpdateStockAsync(id, size, cancellation);
        }

        public async Task UpdateActivityStatusAsync(int id, bool isActive, CancellationToken cancellation = default)
        {
            var product = await CurrentRepository.GetByIdAsync(id, cancellation);
            if (product != null)
            {
                product.IsActive = isActive;
                CurrentRepository.Update(product);
                await UnitOfWork.SaveChangesAsync(cancellation);

            }
        }

        public async Task<bool> HasAnyWithCategoryIdAsync(int categoryId, CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.HasAnyWithCategoryIdAsync(categoryId, cancellationToken);
        }

        public async Task<bool> HasAnyWithSubcategoryIdAsync(int subcategoryId, CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.HasAnyWithSubcategoryIdAsync(subcategoryId, cancellationToken);
        }

        public async Task<bool> HasAnyWithBrandIdAsync(int brandId, CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.HasAnyWithBrandIdAsync(brandId, cancellationToken);
        }
    }
}
