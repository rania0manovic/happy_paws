using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class PetAllergiesRepository : BaseRepository<PetAllergy, int, PetAllergySearchObject>, IPetAllergiesRepository
    {
        public PetAllergiesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
