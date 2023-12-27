using HappyPaws.Core.Dtos.Allergy;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class AllergyProfile : BaseProfile
    {
        public AllergyProfile()
        {
            CreateMap<Allergy, AllergyDto>().ReverseMap();
        }
    }
}
