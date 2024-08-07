﻿using HappyPaws.Core.Entities;
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
    public class UserAddressesRepository : BaseRepository<UserAddress, int, UserAddressSearchObject>, IUserAddressesRepository
    {
        public UserAddressesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<UserAddress>> GetPagedAsync(UserAddressSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x => searchObject.UserId == null || (x.UserId == searchObject.UserId && x.IsInitialUserAddress)).ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
