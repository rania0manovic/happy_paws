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
        public DateTime? DateTime { get; set; }

        public required Pet Pet { get; set; }
        public int PetId { get; set; }
    }
}
