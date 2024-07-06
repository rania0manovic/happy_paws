using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetBreed;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class PetsBreedsService : BaseService<PetBreed, PetBreedDto, IPetBreedsRepository, PetBreedSearchObject>, IPetBreedsService
    {
        public PetsBreedsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<PetBreedDto> validator) : base(mapper, unitOfWork, validator)
        {
        }

        public async Task<List<PetBreedDto>> GetBreedsForPetTypeAsync(int petTypeId, CancellationToken cancellationToken = default, bool isDeletedIncluded = false)
        {
            return Mapper.Map<List<PetBreedDto>>(await CurrentRepository.GetBreedsForPetTypeAsync(petTypeId, cancellationToken));
        }
    }
}
