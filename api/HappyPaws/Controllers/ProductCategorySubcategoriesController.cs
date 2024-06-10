using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.ProductCategorySubcategory;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.OpenApi.Validations.Rules;

namespace HappyPaws.Api.Controllers
{

    public class ProductCategorySubcategoriesController : BaseCrudController<ProductCategorySubcategoryDto, IProductCategorySubcategoriesService, ProductCategorySubcategorySearchObject>
    {
        private readonly IMemoryCache _memoryCache;
        public ProductCategorySubcategoriesController(IProductCategorySubcategoriesService service, ILogger<BaseController> logger, IMemoryCache memoryCache) : base(service, logger)
        {
            _memoryCache = memoryCache;
        }
        [HttpGet("GetSubcategoryIdsForCategory")]
        public async Task<IActionResult> GetSubcategoryIdsForCategory(int categoryId, CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await Service.GetSubcategoryIdsForCategoryAsync(categoryId, cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource with categoryID {CategoryId}", categoryId);
                return BadRequest();
            }
        }
        [HttpGet("GetSubcategoriesForCategory")]
        public async Task<IActionResult> GetSubcategoriesForCategory(int categoryId, bool includePhotos = false, CancellationToken cancellationToken = default)
        {
            try
            {
                string cacheKey = $"SubcategoriesForCategory_{categoryId}_includePhotos_{includePhotos}";
                if (_memoryCache.TryGetValue<List<ProductCategorySubcategoryDto>>(cacheKey, out var subcategories))
                {
                    return Ok(subcategories);
                }

                var response = await Service.GetSubcategoriesForCategoryAsync(categoryId, includePhotos, cancellationToken);
                _memoryCache.Set(cacheKey, response, TimeSpan.FromDays(1));
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource with categoryID {CategoryId}", categoryId);
                return BadRequest();
            }
        }


    }
}
