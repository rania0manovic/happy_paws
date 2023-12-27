using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class PetProfile : BaseProfile
    {
        public PetProfile()
        {
            CreateMap<Pet, PetDto>().ReverseMap();
        }
    }
}
