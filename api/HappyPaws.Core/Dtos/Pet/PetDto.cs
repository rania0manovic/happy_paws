using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.Dtos.PetBreed;
using HappyPaws.Core.Dtos.User;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Pet
{
    public class PetDto:BaseDto
    {
        public required string Name { get; set; }
        public DateTime BirthDate { get; set; }
        public double Weight { get; set; }

        public required UserDto Owner { get; set; }
        public int OwnerId { get; set; }

        public required PetBreedDto PetBreed { get; set; }
        public int PetBreedId { get; set; }

        public ImageDto? Photo { get; set; }
        public int? PhotoId { get; set; }
    }
}
