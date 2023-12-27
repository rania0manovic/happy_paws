using HappyPaws.Core.Dtos.UserFavourite;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class UserFavouriteProfile : BaseProfile
    {
        public UserFavouriteProfile()
        {
            CreateMap<UserFavourite, UserFavouriteDto>().ReverseMap();
        }
    }
}
