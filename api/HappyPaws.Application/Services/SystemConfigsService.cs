﻿using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.SystemConfig;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Exceptions;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Services
{
    public class SystemConfigsService : BaseService<SystemConfig, SystemConfigDto, ISystemConfigsRepository, SystemConfigSearchObject>, ISystemConfigsService
    {
        public SystemConfigsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<SystemConfigDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
