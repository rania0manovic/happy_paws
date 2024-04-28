using AutoMapper;
using HappyPaws.Core.Dtos.Donation;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class DonationProfile : BaseProfile
    {
        public DonationProfile()
        {
            CreateMap<Donation, DonationDto>().ReverseMap();
        }
    }
}
