using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.ProductCategory;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;

namespace HappyPaws.Api.Controllers
{
    public class ProductsController : BaseCrudController<ProductDto, IProductsService, ProductSearchObject>
    {
        private readonly CurrentUser _currentUser;
        private readonly IMemoryCache _memoryCache;
        public ProductsController(IProductsService service, ILogger<BaseController> logger, CurrentUser currentUser, IMemoryCache memoryCache) : base(service, logger)
        {
            _currentUser = currentUser;
            _memoryCache = memoryCache;
        }

        public override async Task<IActionResult> Post([FromForm] ProductDto upsertDto, CancellationToken cancellationToken = default)
        {
            try
            {
                var result = await Service.AddAsync(upsertDto, cancellationToken);
                if (result != null)
                {
                    var product = await Service.GetByIdAsync(result.Id, cancellationToken);
                    return Ok(product);
                }
                else throw new Exception();
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when posting resource for product");
                return BadRequest();
            }
        }
        public override async Task<IActionResult> Put([FromForm] ProductDto upsertDto, CancellationToken cancellationToken = default)
        {
            try
            {
                var result = await Service.UpdateAsync(upsertDto, cancellationToken);
                if (result != null)
                {
                    var product = await Service.GetByIdAsync(upsertDto.Id, cancellationToken);
                    return Ok(product);
                }
                else throw new Exception();
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when updating resource for productId {ProductId}", upsertDto.Id);
                return BadRequest();
            }
        }

        [HttpGet("{id}")]
        public override async Task<IActionResult> Get(int id, CancellationToken cancellationToken = default)
        {
            var userId = _currentUser.Id;
            try
            {
                if (!userId.HasValue) return StatusCode(403);
                var dto = await Service.GetByIdAsync(id, userId.Value, cancellationToken);
                return Ok(dto);

            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource for userId {UserId} and productId {ProductId}", userId, id);
                return BadRequest();
            }
        }

        [HttpGet("Bestsellers")]
        public async Task<IActionResult> GetBestsellers(int size, CancellationToken cancellationToken = default)
        {
            try
            {
                if (_memoryCache.TryGetValue<PagedList<ProductCategoryDto>>("bestseller", out var bestsellers))
                {
                    return Ok(bestsellers);
                }

                var dto = await Service.GetBestsellersAsync(size, cancellationToken);
                _memoryCache.Set("bestsellers", dto, TimeSpan.FromDays(1));
                return Ok(dto);

            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting bestsellers");
                return BadRequest();
            }
        }

        [HttpPut("{id}/{stock}")]
        public async Task<IActionResult> Update(int id, int stock, CancellationToken cancellationToken = default)
        {
            try
            {
                await Service.UpdateStockAsync(id, stock, cancellationToken);
                return Ok();

            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when updating stock resources for id {id}", id);
                return BadRequest();
            }
        }

        [HttpPatch("ActivityStatus")]
        public async Task<IActionResult> UpdateActivityStatus([FromBody] ProductPatchDto dto, CancellationToken cancellationToken = default)
        {
            try
            {
                await Service.UpdateActivityStatusAsync(dto.Id, dto.IsActive, cancellationToken);
                return Ok();

            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when updating stock resources for id {id}", dto.Id);
                return BadRequest();
            }
        }

        [HttpGet("HasAnyWithCategoryId/{categoryId}")]
        public async Task<IActionResult> HasAnyWithCategoryId(int categoryId, CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await Service.HasAnyWithCategoryIdAsync(categoryId, cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when checking for any products with category id {CategoryId}!", categoryId);
                return BadRequest();
            }
        }

        [HttpGet("HasAnyWithSubcategoryId/{subcategoryId}")]
        public async Task<IActionResult> HasAnyWithSubcategoryId(int subcategoryId, CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await Service.HasAnyWithSubcategoryIdAsync(subcategoryId, cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when checking for any products with subcategory id {SubcategoryId}!", subcategoryId);
                return BadRequest();
            }
        }

        [HttpGet("HasAnyWithBrandId/{brandId}")]
        public async Task<IActionResult> HasAnyWithBrandId(int brandId, CancellationToken cancellationToken = default)
        {
            try
            {
                var response = await Service.HasAnyWithBrandIdAsync(brandId, cancellationToken);
                return Ok(response);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when checking for any products with brand id {BrandId}!", brandId);
                return BadRequest();
            }
        }
    }
}
