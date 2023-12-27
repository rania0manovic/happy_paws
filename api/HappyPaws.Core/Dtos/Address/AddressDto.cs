using HappyPaws.Core.Dtos.City;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Address
{
    public class AddressDto : BaseDto
    {
        public required string AddressOne { get; set; }
        public string? AddressTwo { get; set; }
        public required string PostalCode { get; set; }
        public string? Note { get; set; }

        public required CityDto City { get; set; }
        public int CityId { get; set; }
    }
}
