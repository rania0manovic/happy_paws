using FluentValidation;
using HappyPaws.Core.Dtos.UserFavourite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class UserFavouriteValidator : AbstractValidator<UserFavouriteDto>
    {
        public UserFavouriteValidator()
        {

        }
    }
}
