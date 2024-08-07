﻿using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Interfaces
{
    public interface IUserCartsRepository : IBaseRepository<UserCart, int, UserCartSearchObject>
    {
        Task<bool> AlreadyInCartAsync(int productId,int userId, CancellationToken cancellationToken = default);
    }
}
