using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetMedication;
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
    public class PetMedicationsService : BaseService<PetMedication, PetMedicationDto, IPetMedicationsRepository, PetMedicationSearchObject>, IPetMedicationsService
    {
        public PetMedicationsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<PetMedicationDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
