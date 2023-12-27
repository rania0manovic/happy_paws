using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductReview;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class ProductReviewsController : BaseCrudController<ProductReviewDto, IProductReviewsService>
    {
        public ProductReviewsController(IProductReviewsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
