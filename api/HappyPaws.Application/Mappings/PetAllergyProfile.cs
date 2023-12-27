using HappyPaws.Core.Dtos.PetAllergy;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class PetAllergyProfile : BaseProfile
    {
        public PetAllergyProfile()
        {
            CreateMap<PetAllergy, PetAllergyDto>().ReverseMap();
        }
    }
}
