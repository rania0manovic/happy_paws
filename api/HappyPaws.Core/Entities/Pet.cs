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

        public User Owner { get; set; } = null!;
        public int OwnerId { get; set; }

        public PetBreed PetBreed { get; set; } = null!;
        public int PetBreedId { get; set; }

        public Image? Photo { get; set; }
        public int? PhotoId { get; set; }

        public  ICollection<Appointment>? Appointments { get; set; }
        public  ICollection<PetAllergy>? PetAllergies { get; set; }
        public  ICollection<PetMedication>? PetMedications { get; set; }

    }
}
