using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductSubcategory;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    [Authorize(Policy = "AllVerified")]
    public class ProductSubcategoriesController : BaseCrudController<ProductSubcategoryDto, IProductSubcategoriesService, ProductSubcategorySearchObject>
    {
        public ProductSubcategoriesController(IProductSubcategoriesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Post([FromBody] ProductSubcategoryDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }

        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Put([FromBody] ProductSubcategoryDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Put(upsertDto, cancellationToken);
        }

        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Delete(int id, CancellationToken cancellationToken = default)
        {
            return base.Delete(id, cancellationToken);
        }
    }
}
