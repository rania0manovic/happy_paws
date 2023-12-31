﻿using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Other;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class BrandsRepository : BaseRepository<Brand, int>, IBrandsRepository
    {
        public BrandsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<Brand>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x => !x.IsDeleted).ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
