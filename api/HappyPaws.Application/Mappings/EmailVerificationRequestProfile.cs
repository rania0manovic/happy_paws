using HappyPaws.Core.Dtos.EmailVerificationRequest;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class EmailVerificationRequestProfile : BaseProfile
    {
        public EmailVerificationRequestProfile()
        {
            CreateMap<EmailVerificationRequest, EmailVerificationRequestDto>().ReverseMap();
        }
    }
}
