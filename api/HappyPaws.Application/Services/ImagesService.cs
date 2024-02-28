using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class ImagesService : BaseService<Image, ImageDto, IImagesRepository, BaseSearchObject>, IImagesService
    {
        public ImagesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ImageDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
