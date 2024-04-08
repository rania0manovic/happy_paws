using HappyPaws.Core.Dtos.PetMedication;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IPetMedicationsService:IBaseService<int, PetMedicationDto, PetMedicationSearchObject>
    {
    }
}
