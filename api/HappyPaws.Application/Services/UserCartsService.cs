using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.UserCart;
using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class UserCartsService : BaseService<UserCart, UserCartDto, IUserCartsRepository>, IUserCartsService
    {
        public UserCartsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserCartDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
