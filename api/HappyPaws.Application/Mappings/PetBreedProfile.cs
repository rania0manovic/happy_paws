using HappyPaws.Core.Dtos.PetBreed;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class PetBreedProfile : BaseProfile
    {
        public PetBreedProfile()
        {
            CreateMap<PetBreed, PetBreedDto>().ReverseMap();
        }
    }
}
