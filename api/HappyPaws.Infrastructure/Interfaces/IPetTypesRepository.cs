﻿using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Interfaces
{
    public interface IPetTypesRepository : IBaseRepository<PetType, int, PetTypeSearchObject>
    {
    }
}
