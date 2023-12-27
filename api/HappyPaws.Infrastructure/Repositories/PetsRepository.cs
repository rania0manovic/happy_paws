using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class PetsRepository : BaseRepository<Pet, int>, IPetsRepository
    {
        public PetsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
