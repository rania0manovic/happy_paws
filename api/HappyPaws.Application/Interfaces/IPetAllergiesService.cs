using HappyPaws.Core.Dtos.PetAllergy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IPetAllergiesService : IBaseService<int, PetAllergyDto>
    {
    }
}
