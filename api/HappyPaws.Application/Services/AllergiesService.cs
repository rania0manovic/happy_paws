using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Allergy;
using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Services
{
    public class AllergiesService : BaseService<Allergy, AllergyDto, IAllergiesRepository>, IAllergiesService
    {
        public AllergiesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<AllergyDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
