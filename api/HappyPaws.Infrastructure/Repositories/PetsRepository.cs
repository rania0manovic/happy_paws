using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Other;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class PetsRepository : BaseRepository<Pet, int, PetSearchObject>, IPetsRepository
    {
        public PetsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<Pet>> GetPagedAsync(PetSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x => x.Photo)
                .Include(x => x.PetBreed)
                .ThenInclude(x => x.PetType)
                .Include(x => x.PetAllergies)
                .Include(x => x.PetMedications)
                .Include(x => x.Owner)
                .Where(x => (searchObject.UserId == null || x.OwnerId == searchObject.UserId) &&
                (searchObject.MyPawNumber == null || x.Owner.MyPawNumber.StartsWith(searchObject.MyPawNumber))
                ).ToPagedListAsync(searchObject, cancellationToken);
        }
        public override async Task<Pet?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            return await DbSet
                .Include(x => x.Photo)
                .Include(x => x.PetBreed)
                .ThenInclude(x => x.PetType)
                .Include(x => x.PetAllergies)
                .Include(x => x.PetMedications)
                .Include(x => x.Owner)
                .FirstOrDefaultAsync(x => x.Id == id, cancellationToken);
        }
    }
}
