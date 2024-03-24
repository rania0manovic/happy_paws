using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class ProductsController : BaseCrudController<ProductDto, IProductsService, ProductSearchObject>
    {
        private readonly CurrentUser _currentUser;
        public ProductsController(IProductsService service, ILogger<BaseController> logger, CurrentUser currentUser) : base(service, logger)
        {
            _currentUser = currentUser;
        }

        public override Task<IActionResult> Post([FromForm] ProductDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }
        public override Task<IActionResult> Put([FromForm] ProductDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Put(upsertDto, cancellationToken);
        }

        [HttpGet("{id}")]
        public override async Task<IActionResult> Get(int id, CancellationToken cancellationToken = default)
        {
            var userId = _currentUser.Id;
            try
            {
                if (!userId.HasValue) return StatusCode(403);
                var dto = await Service.GetByIdAsync(id, userId.Value, cancellationToken);
                return Ok(dto);

            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource for userId {UserId} and productId {ProductId}", userId, id);
                return BadRequest();
            }
        }
    }
}
