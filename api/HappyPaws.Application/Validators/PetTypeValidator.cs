using FluentValidation;
using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.Dtos.PetType;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class PetTypeValidator : AbstractValidator<PetTypeDto>
    {
        public PetTypeValidator()
        {
            RuleFor(x => x.Name).NotEmpty().NotNull();
        }
    }
}
