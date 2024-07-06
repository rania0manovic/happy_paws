using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.SearchObjects
{
    public class PetMedicationSearchObject:BaseSearchObject
    {
        public DateTime? MinDateTime { get; set; }
    }
}
