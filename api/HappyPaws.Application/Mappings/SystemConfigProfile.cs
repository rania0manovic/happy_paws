﻿using HappyPaws.Core.Dtos.SystemConfig;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class SystemConfigProfile : BaseProfile
    {
        public SystemConfigProfile()
        {
            CreateMap<SystemConfig, SystemConfigDto>().ReverseMap();

        }
    }
}
