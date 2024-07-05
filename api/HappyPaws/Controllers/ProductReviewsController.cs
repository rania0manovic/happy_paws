using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductReview;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class ProductReviewsController : BaseCrudController<ProductReviewDto, IProductReviewsService, ProductReviewSearchObject>
    {
        private readonly CurrentUser user;
        public ProductReviewsController(IProductReviewsService service, ILogger<BaseController> logger, CurrentUser user) : base(service, logger)
        {
            this.user = user;
        }

        [Authorize(Roles ="User")]
        public override Task<IActionResult> Post([FromBody] ProductReviewDto upsertDto, CancellationToken cancellationToken = default)
        {
            if (user.Id.HasValue)
            {
                upsertDto.ReviewerId = user.Id.Value;
                return base.Post(upsertDto, cancellationToken);
            }
            else throw new UnauthorizedAccessException();
        }
    }
}
