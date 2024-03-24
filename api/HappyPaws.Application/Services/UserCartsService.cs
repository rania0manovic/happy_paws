using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.UserCart;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class UserCartsService : BaseService<UserCart, UserCartDto, IUserCartsRepository, UserCartSearchObject>, IUserCartsService
    {
        public UserCartsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserCartDto> validator) : base(mapper, unitOfWork, validator)
        {
        }

        public async Task<bool> AlreadyInCartAsync(int productId,int userId, CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.AlreadyInCartAsync(productId, userId, cancellationToken).ConfigureAwait(false);
        }

        public override async Task<UserCartDto> UpdateAsync(UserCartDto dto, CancellationToken cancellationToken = default)
        {
            var entity = await GetByIdAsync(dto.Id);
            if (entity != null)
            {
                entity.Quantity = dto.Quantity;
                return await base.UpdateAsync(entity, cancellationToken);
            }
            else throw new Exception($"Product in cart with id: {dto.Id} not found.");
        }

    }
}
