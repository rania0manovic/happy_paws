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
    public class AddressesService : BaseService<Address, AddressDto, IAddressesRepository, AddressSearchObject>, IAddressesService
    {
        public AddressesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<AddressDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
