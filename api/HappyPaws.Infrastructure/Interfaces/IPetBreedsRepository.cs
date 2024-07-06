using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;

namespace HappyPaws.Infrastructure.Interfaces
{
    public interface IPetBreedsRepository : IBaseRepository<PetBreed, int, PetBreedSearchObject>
    {
        Task<List<PetBreed>> GetBreedsForPetTypeAsync(int petTypeId, CancellationToken cancellationToken = default, bool isDeletedIncluded = false);

    }
}
