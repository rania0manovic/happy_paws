using HappyPaws.Core.Dtos.Country;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface ICountriesService : IBaseService<int, CountryDto, CountrySearchObject>
    {
    }
}
