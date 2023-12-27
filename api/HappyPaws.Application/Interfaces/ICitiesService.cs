using HappyPaws.Core.Dtos.City;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface ICitiesService : IBaseService<int, CityDto>
    {
    }
}
