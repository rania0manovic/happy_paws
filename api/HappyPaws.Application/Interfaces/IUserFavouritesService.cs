﻿using HappyPaws.Core.Dtos.UserFavourite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IUserFavouritesService : IBaseService<int, UserFavouriteDto>
    {
    }
}
