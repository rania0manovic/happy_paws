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

        public override Task<IActionResult> Post([FromForm] ProductDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }
        public override Task<IActionResult> Put([FromForm] ProductDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Put(upsertDto, cancellationToken);
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
        [HttpGet("RecommendedProductsForUser")]
        public async Task<IActionResult> GetRecommendedProductsForUser(int size, CancellationToken cancellationToken = default)
        {
            var userId = _currentUser.Id;

            try
            {
                if (!userId.HasValue) return StatusCode(403);
                string cacheKey = $"RecommendedProducts_{userId.Value}";
                if (_memoryCache.TryGetValue<List<ProductDto>>(cacheKey, out var recommendedProducts))
                {
                    return Ok(recommendedProducts);
                }

                var dto = await Service.GetRecommendedProductsForUserAsync(userId.Value, size, cancellationToken);
                _memoryCache.Set(cacheKey, dto, TimeSpan.FromDays(1));
                return Ok(dto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource for userId {UserId} ", userId);
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
    }
}
