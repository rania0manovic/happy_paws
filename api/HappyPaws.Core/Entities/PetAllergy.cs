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
        public AllergySeverity AllergySeverity { get; set; }

        public required Pet Pet { get; set; } 
        public int PetId { get; set; }

        public required Allergy Allergy { get; set; }
        public int AllergyId { get; set; }
    }
}
