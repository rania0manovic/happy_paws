using HappyPaws.Core.Dtos.PetType;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class PetTypeProfile : BaseProfile
    {
        public PetTypeProfile()
        {
            CreateMap<PetType, PetTypeDto>().ReverseMap();
        }
    }
}
