using HappyPaws.Core.Dtos.PetBreed;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IPetBreedsService : IBaseService<int, PetBreedDto, PetBreedSearchObject>
    {
    }
}
