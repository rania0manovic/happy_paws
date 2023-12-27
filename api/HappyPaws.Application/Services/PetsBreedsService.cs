using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetBreed;
using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class PetsBreedsService : BaseService<PetBreed, PetBreedDto, IPetBreedsRepository>, IPetBreedsService
    {
        public PetsBreedsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<PetBreedDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
