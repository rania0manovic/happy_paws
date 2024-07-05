using FluentValidation;
using HappyPaws.Core.Dtos.PetAllergy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class PetAllergyValidator : AbstractValidator<PetAllergyDto>
    {
        public PetAllergyValidator()
        {
            RuleFor(x => x.Name).NotNull().NotEmpty();
            RuleFor(x => x.AllergySeverity).NotNull();
            RuleFor(x => x.PetId).NotNull();

        }
    }
}
