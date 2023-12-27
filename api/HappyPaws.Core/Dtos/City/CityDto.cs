using HappyPaws.Core.Dtos.Country;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.City
{
    public class CityDto:BaseDto
    {
        public required string Name { get; set; }

        public required CountryDto Country { get; set; }
        public int CountryId { get; set; }
    }
}
