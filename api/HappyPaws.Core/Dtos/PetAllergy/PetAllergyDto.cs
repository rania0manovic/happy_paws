using HappyPaws.Core.Dtos.Allergy;
using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.PetAllergy
{
    public class PetAllergyDto:BaseDto
    {
        public required string Name { get; set; }
      
        public AllergySeverity AllergySeverity { get; set; }

        public PetDto? Pet { get; set; }
        public int PetId { get; set; }

       
    }
}
