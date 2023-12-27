using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Country
{
    public class CountryDto:BaseDto
    {
        public required string Name { get; set; }
        public required string Code { get; set; }
    }
}
