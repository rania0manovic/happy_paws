using HappyPaws.Core.Dtos.Helpers;
using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IPetsService : IBaseService<int, PetDto, PetSearchObject>
    {
        Task<int> GetCountAsync(CancellationToken cancellationToken = default);
        Task<List<PetTypeCountDto>> GetCountByPetTypeAsync(CancellationToken cancellationToken = default);
        Task<bool> HasAnyWithPetTypeIdAsync(int petTypeId, CancellationToken cancellationToken = default);
        Task<bool> HasAnyWithPetBreedIdAsync(int petBreedId, CancellationToken cancellationToken = default);

    }
}
