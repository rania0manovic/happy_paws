using FluentValidation;
using HappyPaws.Core.Dtos.Image;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class ImageValidator : AbstractValidator<ImageDto>
    {
        public ImageValidator()
        {
            
        }
    }
}
