using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetAllergy;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class PetAllergiesService : BaseService<PetAllergy, PetAllergyDto, IPetAllergiesRepository, PetAllergySearchObject>, IPetAllergiesService
    {
        public PetAllergiesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<PetAllergyDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
