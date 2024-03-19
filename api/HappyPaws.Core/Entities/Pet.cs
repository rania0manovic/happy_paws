using HappyPaws.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class Pet : BaseEntity
    {
        public required string Name { get; set; }
        public DateTime BirthDate { get; set; }
        public double Weight { get; set; }
        public Gender Gender { get; set; }

        public required User Owner { get; set; }
        public int OwnerId { get; set; }

        public required PetBreed PetBreed { get; set; }
        public int PetBreedId { get; set; }

        public Image? Photo { get; set; }
        public int? PhotoId { get; set; }

        public required ICollection<Appointment> Appointments { get; set; }
        public required ICollection<PetAllergy> PetAllergies { get; set; }

    }
}
