using HappyPaws.Core.Dtos.PetType;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IPetTypesService : IBaseService<int, PetTypeDto>
    {
    }
}
