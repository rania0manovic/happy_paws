using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class UserProfile : BaseProfile
    {
        public UserProfile()
        {
            CreateMap<User, UserDto>().ReverseMap();
            CreateMap<SignUpModel, UserSensitiveDto>();
            CreateMap<UserSensitiveDto, User>().ReverseMap();
            CreateMap<UserDto, UserSensitiveDto>();
        }
    }
}
