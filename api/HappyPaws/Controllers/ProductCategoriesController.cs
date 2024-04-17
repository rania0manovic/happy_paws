using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductCategory;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;

namespace HappyPaws.Api.Controllers
{
    public class ProductCategoriesController : BaseCrudController<ProductCategoryDto, IProductCategoriesService, ProductCategorySearchObject>
    {
        private readonly IMemoryCache _memoryCache;
        public ProductCategoriesController(IProductCategoriesService service, ILogger<BaseController> logger, IMemoryCache memoryCache) : base(service, logger)
        {
            _memoryCache = memoryCache;
        }

        public async override Task<IActionResult> GetPaged([FromQuery] ProductCategorySearchObject searchObject, CancellationToken cancellationToken = default)
        {
            if (_memoryCache.TryGetValue<PagedList<ProductCategoryDto>>("productCategories", out var productCategories))
            {
                return Ok(productCategories);
            }

            var dto = await Service.GetPagedAsync(searchObject, cancellationToken);
            _memoryCache.Set("productCategories", dto, TimeSpan.FromDays(1));
            return Ok(dto);
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
