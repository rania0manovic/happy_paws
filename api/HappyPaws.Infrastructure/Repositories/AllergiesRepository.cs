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
    public class AllergiesRepository : BaseRepository<Allergy, int, AllergySearchObject>, IAllergiesRepository
    {
        public AllergiesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
