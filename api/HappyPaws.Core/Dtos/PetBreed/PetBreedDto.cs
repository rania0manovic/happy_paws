using HappyPaws.Core.Dtos.PetType;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.PetBreed
{
    public class PetBreedDto:BaseDto
    {
        public required string Name { get; set; }

        public required PetTypeDto PetType { get; set; }
        public int PetTypeId { get; set; }
    }
}
