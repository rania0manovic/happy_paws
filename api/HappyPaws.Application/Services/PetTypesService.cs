﻿using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetType;
using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class PetTypesService : BaseService<PetType, PetTypeDto, IPetTypesRepository>, IPetTypesService
    {
        public PetTypesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<PetTypeDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
