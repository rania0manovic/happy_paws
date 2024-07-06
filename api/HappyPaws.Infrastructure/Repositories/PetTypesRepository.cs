using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Other;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class PetTypesRepository : BaseRepository<PetType, int, PetTypeSearchObject>, IPetTypesRepository
    {
        public PetTypesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<PetType>> GetPagedAsync(PetTypeSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x=>searchObject.Name==null ||x.Name.StartsWith(searchObject.Name)).ToPagedListAsync(searchObject,cancellationToken);
        }
    }
}
