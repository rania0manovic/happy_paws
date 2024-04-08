using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class PetProfile : BaseProfile
    {
        public PetProfile()
        {
            CreateMap<Pet, PetDto>().ReverseMap();
                //.ForMember(dest => dest.Owner, opt => opt.MapFrom(src => src.Owner))
                //.ForMember(dest => dest.Photo, opt => opt.MapFrom(src => src.Photo))
                //.ForMember(dest => dest.PetBreed, opt => opt.MapFrom(src => src.PetBreed))
                //.ForPath(dest => dest.PetBreed.PetType, opt => opt.MapFrom(src => src.PetBreed.PetType))
                //.ForMember(dest => dest.PetMedications, opt => opt.MapFrom(src => src.PetMedications))
                //.ForMember(dest => dest.PetAllergies, opt => opt.MapFrom(src => src.PetAllergies))
                //.ReverseMap();
        }
    }
}
