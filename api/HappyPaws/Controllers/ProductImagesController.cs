using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductImage;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class ProductImagesController : BaseCrudController<ProductImageDto, IProductImageService, BaseSearchObject>
    {
        public ProductImagesController(IProductImageService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
