using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductCategory;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;

namespace HappyPaws.Api.Controllers
{
    [Authorize(Policy = "AllVerified")]
    public class ProductCategoriesController : BaseCrudController<ProductCategoryDto, IProductCategoriesService, ProductCategorySearchObject>
    {
        private readonly IMemoryCache _memoryCache;
        private readonly IProductCategorySubcategoriesService _productCategorySubcategoriesService;
        public ProductCategoriesController(IProductCategoriesService service, ILogger<BaseController> logger, IMemoryCache memoryCache, IProductCategorySubcategoriesService productCategorySubcategoriesService) : base(service, logger)
        {
            _memoryCache = memoryCache;
            _productCategorySubcategoriesService = productCategorySubcategoriesService;
        }

        [Authorize(Roles ="Admin")]
        public override async Task<IActionResult> Post([FromBody] ProductCategoryDto upsertDto, CancellationToken cancellationToken = default)
        {
            if (upsertDto.AddedIds != null)
                upsertDto.AddedSubcategoryIds = upsertDto.AddedIds.Split(',').Select(int.Parse).ToList();
            var result = await Service.AddAsync(upsertDto, cancellationToken);
            return Ok(result);
        }

        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Delete(int id, CancellationToken cancellationToken = default)
        {
            if (_memoryCache.TryGetValue<PagedList<ProductCategoryDto>>("productCategories", out var productCategories))
            {
                productCategories?.Items.RemoveAll(x => x.Id == id);
                _memoryCache.Set("productCategories", productCategories, TimeSpan.FromDays(1));
            }
            return base.Delete(id, cancellationToken);
        }

        [Authorize(Roles = "Admin")]
        public override async Task<IActionResult> Put([FromBody] ProductCategoryDto upsertDto, CancellationToken cancellationToken = default)
        {
            try
            {
                if (upsertDto.RemovedIds != null)
                    upsertDto.RemovedSubcategoryIds = upsertDto.RemovedIds.Split(',').Select(int.Parse).ToList();
                if (upsertDto.AddedIds != null)
                    upsertDto.AddedSubcategoryIds = upsertDto.AddedIds.Split(',').Select(int.Parse).ToList();
                var result = await Service.UpdateAsync(upsertDto, cancellationToken);
                return Ok(result);
            }
            catch (Exception)
            {
                return BadRequest();
            }
        }

    }
}
