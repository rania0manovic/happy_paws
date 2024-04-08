using HappyPaws.Core.Dtos.PetMedication;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class PetMedicationProfile:BaseProfile
    {
        public PetMedicationProfile()
        {
            CreateMap<PetMedication, PetMedicationDto>().ReverseMap();

        }
    }
}
