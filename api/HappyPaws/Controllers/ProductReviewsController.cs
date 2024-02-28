using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductReview;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class ProductReviewsController : BaseCrudController<ProductReviewDto, IProductReviewsService, ProductReviewSearchObject>
    {
        public ProductReviewsController(IProductReviewsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
