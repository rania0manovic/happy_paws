using HappyPaws.Core.Dtos.Pet;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Appointment
{
    public class AppointmentDto : BaseDto
    {
        public required string Reason { get; set; }
        public string? Note { get; set; }
        public DateTime? DateTime { get; set; }
        public bool IsCancelled { get; set; }

        public PetDto? Pet { get; set; }
        public int PetId { get; set; }
    }
}
