using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class Appointment : BaseEntity
    {
        public required string Reason { get; set; }
        public string? Note { get; set; }
        public DateTime? StartDateTime { get; set; }
        public DateTime? EndDateTime { get; set; }
        public bool IsCancelled { get; set; }

        public Pet Pet { get; set; } = null!;
        public int PetId { get; set; }

        public User? Employee { get; set; }
        public int? EmployeeId { get; set; }

    }
}
