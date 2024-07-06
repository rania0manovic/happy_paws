using HappyPaws.Core.Dtos.Pet;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.PetMedication
{
    public class PetMedicationDto:BaseDto
    {
        public required string MedicationName { get; set; }
        public double Dosage { get; set; }
        public int DosageFrequency { get; set; }
        public DateTime Until { get; set; }

        public PetDto? Pet { get; set; }
        public int PetId { get; set; }
    }
}
