using FluentValidation;
using HappyPaws.Core.Dtos.Country;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class CountryValidator : AbstractValidator<CountryDto>
    {
        public CountryValidator()
        {

        }
    }
}
