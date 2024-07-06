using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Helpers
{
    public class PetTypeCountDto
    {
        public string Name { get; set; } = null!;
        public int Count { get; set; }
    }
}
