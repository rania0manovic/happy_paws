using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class ProductsController : BaseCrudController<ProductDto, IProductsService, ProductSearchObject>
    {
        public ProductsController(IProductsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }

        public override Task<IActionResult> Post([FromForm] ProductDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }
        public override Task<IActionResult> Put([FromForm] ProductDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Put(upsertDto, cancellationToken);
        }

        [HttpGet("{id}/{userId}")]
        public async Task<IActionResult> Get(int id, int userId, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await Service.GetByIdAsync(id, userId, cancellationToken);
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
