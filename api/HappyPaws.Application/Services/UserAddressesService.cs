using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Address;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class UserAddressesService : BaseService<UserAddress, UserAddressDto, IUserAddressesRepository, UserAddressSearchObject>, IUserAddressesService
    {
        public UserAddressesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserAddressDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
