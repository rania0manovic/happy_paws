using HappyPaws.Core.Dtos.PetBreed;
using HappyPaws.Core.SearchObjects;

namespace HappyPaws.Application.Interfaces
{
    public interface IPetBreedsService : IBaseService<int, PetBreedDto, PetBreedSearchObject>
    {
        Task<List<PetBreedDto>> GetBreedsForPetTypeAsync(int petTypeId, CancellationToken cancellationToken = default, bool isDeletedIncluded = false);

    }
}
