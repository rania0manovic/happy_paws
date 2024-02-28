using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductSubcategory;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class ProductSubcategoriesController : BaseCrudController<ProductSubcategoryDto, IProductSubcategoriesService, ProductSubcategorySearchObject>
    {
        public ProductSubcategoriesController(IProductSubcategoriesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        public override Task<IActionResult> Post([FromForm] ProductSubcategoryDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }
        public override Task<IActionResult> Put([FromForm] ProductSubcategoryDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Put(upsertDto, cancellationToken);
        }
    }
}
