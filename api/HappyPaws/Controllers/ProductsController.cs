using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Product;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class ProductsController : BaseCrudController<ProductDto, IProductsService>
    {
        public ProductsController(IProductsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }

        public override Task<IActionResult> Post([FromForm] ProductDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }
    }
}
