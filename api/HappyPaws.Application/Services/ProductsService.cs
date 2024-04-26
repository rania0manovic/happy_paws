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
using Microsoft.IdentityModel.Tokens;
using System.Linq;

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
                if (dto.ImageFiles != null)
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
        public override async Task<PagedList<ProductDto>> GetPagedAsync(ProductSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var response = await base.GetPagedAsync(searchObject, cancellationToken);
            foreach (var item in response.Items)
            {
                if (item != null && item.ProductReviews != null && item.ProductReviews.Count > 0)
                {
                    item.Review = (int)item.ProductReviews.Average(x => x.Review);
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

        public async Task<List<ProductDto>> GetRecommendedProductsForUserAsync(int userId, int size, CancellationToken cancellationToken = default)
        {
            var favouriteProducts = await _userFavouritesService.GetPagedProductsAsync(new UserFavouriteSearchObject() { UserId = userId }, cancellationToken);
            if (favouriteProducts != null && favouriteProducts.TotalCount > 0)
            {
                var similarProducts = await CurrentRepository.FindSimilarProductsAsync(favouriteProducts.Items, size, cancellationToken);
                if (similarProducts != null) { return Mapper.Map<List<ProductDto>>(similarProducts); }
                else return new();
            }
            return new();

        }

        public async Task<List<ProductDto>> GetBestsellersAsync(int size, CancellationToken cancellationToken = default)
        {
            return Mapper.Map<List<ProductDto>>(await CurrentRepository.GetBestsellersAsync(size, cancellationToken));
        }
    }
}
