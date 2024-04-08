using HappyPaws.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class PetAllergy : BaseEntity
    {
        public required string  Name { get; set; }
        public AllergySeverity AllergySeverity { get; set; }

        public required Pet Pet { get; set; } 
        public int PetId { get; set; }

    }
}
