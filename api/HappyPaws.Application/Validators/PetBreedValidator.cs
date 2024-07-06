using FluentValidation;
using HappyPaws.Core.Dtos.PetBreed;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class PetBreedValidator : AbstractValidator<PetBreedDto>
    {
        public PetBreedValidator()
        {
            RuleFor(x => x.Name).NotNull().NotEmpty();
            RuleFor(x => x.PetTypeId).NotNull();
        }
    }
}
