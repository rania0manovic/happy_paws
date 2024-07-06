using FluentValidation;
using HappyPaws.Core.Dtos.PetMedication;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class PetMedicationValidator : AbstractValidator<PetMedicationDto>
    {
        public PetMedicationValidator()
        {
            RuleFor(x => x.MedicationName).NotNull().NotEmpty();
            RuleFor(x => x.Dosage).NotNull();
            RuleFor(x => x.DosageFrequency).NotNull();
            RuleFor(x => x.Until).NotNull();
            RuleFor(x => x.PetId).NotNull();

        }
    }
}
