using HappyPaws.Core.Dtos.UserCart;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class UserCartProfile : BaseProfile
    {
        public UserCartProfile()
        {
            CreateMap<UserCart, UserCartDto>().ReverseMap();
        }
    }
}
