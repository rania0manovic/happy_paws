using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.UserFavourite;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
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
    public class UserFavouritesService : BaseService<UserFavourite, UserFavouriteDto, IUserFavouritesRepository, UserFavouriteSearchObject>, IUserFavouritesService
    {
        public UserFavouritesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserFavouriteDto> validator) : base(mapper, unitOfWork, validator)
        {
        }

        public async Task<PagedList<ProductDto>> GetPagedProductsAsync(UserFavouriteSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var response = Mapper.Map<PagedList<ProductDto>>(await CurrentRepository.GetPagedProductsAsync(searchObject, cancellationToken));

            foreach (var item in response.Items)
            {
                if (item != null && item.ProductReviews != null && item.ProductReviews.Count > 0)
                {
                    item.Review = (int)item.ProductReviews.Average(x => x.Review);
                }
            }

            return response;
        }
    }
}
