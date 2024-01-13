using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductCategorySubcategory;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.OpenApi.Validations.Rules;

namespace HappyPaws.Api.Controllers
{

    public class ProductCategorySubcategoriesController : BaseCrudController<ProductCategorySubcategoryDto, IProductCategorySubcategoriesService>
    {
        public ProductCategorySubcategoriesController(IProductCategorySubcategoriesService service, ILogger<BaseController> logger) : base(service, logger)
        {
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
                Logger.LogError(e, "Problem when getting resource with categoryID {0}", categoryId);
                return BadRequest();
            }
        }
        [HttpGet("GetSubcategoriesForCategory")]
        public async Task<IActionResult> GetSubcategoriesForCategory(int categoryId, CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await Service.GetSubcategoriesForCategoryAsync(categoryId, cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource with categoryID {0}", categoryId);
                return BadRequest();
            }
        }


    }
}
