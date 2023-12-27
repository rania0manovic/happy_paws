using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Image;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class ImagesController : BaseCrudController<ImageDto, IImagesService>
    {
        public ImagesController(IImagesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
