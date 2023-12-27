using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductImage;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class ProductImagesController : BaseCrudController<ProductImageDto, IProductImageService>
    {
        public ProductImagesController(IProductImageService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
