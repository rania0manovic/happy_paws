﻿using HappyPaws.Core.Dtos.Brand;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IBrandsService : IBaseService<int, BrandDto, BrandSearchObject>
    {
    }
}
