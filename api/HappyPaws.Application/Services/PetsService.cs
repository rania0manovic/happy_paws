using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.Entities;
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
    public class PetsService : BaseService<Pet, PetDto, IPetsRepository, PetSearchObject>, IPetsService
    {
        public PetsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<PetDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
