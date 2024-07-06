using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [Authorize(Policy = "AllVerified")]
    public class ImagesController : BaseCrudController<ImageDto, IImagesService, BaseSearchObject>
    {
        public ImagesController(IImagesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [Authorize]
        public override Task<IActionResult> Delete(int id, CancellationToken cancellationToken = default)
        {
            return base.Delete(id, cancellationToken);
        }
    }
}
