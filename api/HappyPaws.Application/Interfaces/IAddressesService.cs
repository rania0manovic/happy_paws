﻿using HappyPaws.Core.Dtos.Address;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IAddressesService:IBaseService<int, AddressDto, AddressSearchObject>
    {
    }
}
