using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class PetType:BaseEntity
    {
        public required string Name { get; set; }

        public  ICollection<PetBreed>?  PetBreeds { get; set; }
    }
}
