using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Other;
using Microsoft.EntityFrameworkCore;

namespace HappyPaws.Infrastructure.Repositories
{
    public class PetBreedsRepository : BaseRepository<PetBreed, int, PetBreedSearchObject>, IPetBreedsRepository
    {
        public PetBreedsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async Task<List<PetBreed>> GetBreedsForPetTypeAsync(int petTypeId, CancellationToken cancellationToken = default, bool isDeletedIncluded = false)
        {
            return await DbSet.Where(x => x.PetTypeId == petTypeId).ToListAsync(cancellationToken);
        }

        public override async Task<PagedList<PetBreed>> GetPagedAsync(PetBreedSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x=>x.PetType)
                .Where(x=>searchObject.PetTypeId==null || x.PetTypeId==searchObject.PetTypeId)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
