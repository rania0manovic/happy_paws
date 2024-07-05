using FluentValidation;
using HappyPaws.Core.Dtos.Pet;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class PetValidator : AbstractValidator<PetDto>
    {
        public PetValidator()
        {
            RuleFor(x => x.Name).NotNull().NotEmpty();
            RuleFor(x => x.OwnerId).NotNull();
            RuleFor(x => x.Weight).NotNull();
            RuleFor(x => x.Gender).NotNull();
            RuleFor(x => x.PetBreedId).NotNull();
        }
    }
}
