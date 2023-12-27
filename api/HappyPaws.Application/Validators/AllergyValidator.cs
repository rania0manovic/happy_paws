using FluentValidation;
using HappyPaws.Core.Dtos.Allergy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class AllergyValidator : AbstractValidator<AllergyDto>
    {
        public AllergyValidator()
        {

        }
    }
}
