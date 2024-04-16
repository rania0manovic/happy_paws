using HappyPaws.Core.Dtos.Address;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class UserAddressProfile : BaseProfile
    {
        public UserAddressProfile()
        {
            CreateMap<UserAddress, UserAddressDto>().ReverseMap();
        }
    }
}
