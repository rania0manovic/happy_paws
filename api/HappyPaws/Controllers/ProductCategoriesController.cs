using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductCategory;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class ProductCategoriesController : BaseCrudController<ProductCategoryDto, IProductCategoriesService, ProductCategorySearchObject>
    {
        public ProductCategoriesController(IProductCategoriesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        public override Task<IActionResult> Post([FromForm] ProductCategoryDto upsertDto, CancellationToken cancellationToken = default)
        {
            if (upsertDto.AddedIds != null)
                upsertDto.AddedSubcategoryIds = upsertDto.AddedIds.Split(',').Select(int.Parse).ToList();
            return base.Post(upsertDto, cancellationToken);
        }
        public override Task<IActionResult> Put([FromForm] ProductCategoryDto upsertDto, CancellationToken cancellationToken = default)
        {
            if (upsertDto.RemovedIds != null)
                 upsertDto.RemovedSubcategoryIds = upsertDto.RemovedIds.Split(',').Select(int.Parse).ToList();
            if (upsertDto.AddedIds != null)
                upsertDto.AddedSubcategoryIds = upsertDto.AddedIds.Split(',').Select(int.Parse).ToList();
            return base.Put(upsertDto, cancellationToken);
        }
    }
}
