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
    public class PetMedicationsRepository : BaseRepository<PetMedication, int, PetMedicationSearchObject>, IPetMedicationsRepository
    {
        public PetMedicationsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<PetMedication>> GetPagedAsync(PetMedicationSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x=>x.Pet)
                .Where(x=>(searchObject.UserId == null || x.Pet.OwnerId == searchObject.UserId) &&
                (searchObject.MinDateTime == null || x.Until > searchObject.MinDateTime))
                .ToPagedListAsync(searchObject, cancellationToken);  
        }
    }
}
