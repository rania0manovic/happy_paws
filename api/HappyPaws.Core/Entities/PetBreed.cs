using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class PetBreed : BaseEntity
    {
        public required string Name { get; set; }

        public required PetType PetType { get; set; }
        public int PetTypeId { get; set; }

        public required ICollection<Pet> Pets { get; set; }
    }
}
