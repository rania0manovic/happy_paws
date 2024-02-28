using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class ImagesController : BaseCrudController<ImageDto, IImagesService, BaseSearchObject>
    {
        public ImagesController(IImagesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
