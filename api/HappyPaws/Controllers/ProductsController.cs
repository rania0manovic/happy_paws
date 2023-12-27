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
    }
}
