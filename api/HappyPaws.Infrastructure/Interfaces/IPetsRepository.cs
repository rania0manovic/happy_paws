using HappyPaws.Core.Dtos.Helpers;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Interfaces
{
    public interface IPetsRepository : IBaseRepository<Pet, int, PetSearchObject>
    {
        Task<int> GetCountAsync(CancellationToken cancellationToken = default);
        Task<List<PetTypeCountDto>> GetCountByPetTypeAsync(CancellationToken cancellationToken = default);
        Task<bool> HasAnyWithPetTypeIdAsync(int petTypeId, CancellationToken cancellationToken = default);
        Task<bool> HasAnyWithPetBreedIdAsync(int petBreedId, CancellationToken cancellationToken = default);
    }
}
