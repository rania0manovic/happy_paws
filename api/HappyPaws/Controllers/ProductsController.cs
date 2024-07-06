using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Api.HostedServices.Kafka;
using HappyPaws.Application.Interfaces;
using HappyPaws.Application.Services;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.ProductCategory;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;

namespace HappyPaws.Api.Controllers
{
    public class ProductsController : BaseCrudController<ProductDto, IProductsService, ProductSearchObject>
    {
        private readonly CurrentUser _currentUser;
        private readonly IMemoryCache _memoryCache;
        private readonly KafkaProducerHostedService _kafkaProducerHostedService;
        private readonly IUsersService _usersService;
        public ProductsController(IProductsService service, ILogger<BaseController> logger, CurrentUser currentUser, IMemoryCache memoryCache, KafkaProducerHostedService kafkaProducerHostedService, IUsersService usersService) : base(service, logger)
        {
            _currentUser = currentUser;
            _memoryCache = memoryCache;
            _kafkaProducerHostedService = kafkaProducerHostedService;
            _usersService = usersService;
        }

        [Authorize(Roles = "Admin")]
        public override async Task<IActionResult> Post([FromBody] ProductDto upsertDto, CancellationToken cancellationToken = default)
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

        [Authorize(Policy = "AllVerified")]
        public override Task<IActionResult> GetPaged([FromQuery] ProductSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return base.GetPaged(searchObject, cancellationToken);
        }

        [Authorize(Roles = "Admin")]
        [HttpPost("SendNewsLetterForNewArrivalls")]
        public async Task<IActionResult> SendNewsLetterForNewArrivalls([FromBody] List<ProductDto> products, CancellationToken cancellationToken = default)
        {
            try
            {
                var users = await _usersService.GetPagedAsync(new UserSearchObject { PageNumber = 1, PageSize = 100000, OnlySubscribers = true }, cancellationToken);
                var obj = new PromoteProductsToUsers
                {
                    Products = products,
                    UserEmails = users.Items.Select(x => x.Email).ToArray()
                };
                await _kafkaProducerHostedService.SendMessageAsync("promote-new-products", obj);
                return Ok();

            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when trying to send out a promotion");
                return BadRequest();
            }
        }

        [Authorize(Roles = "Admin")]
        public override async Task<IActionResult> Put([FromBody] ProductDto upsertDto, CancellationToken cancellationToken = default)
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

        [Authorize(Policy = "AllVerified")]
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

        [Authorize(Policy = "AllVerified")]
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

        [Authorize(Policy = "RetailStaffOnly")]
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
        [Authorize(Roles = "Admin")]
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
        [Authorize(Roles = "Admin")]
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
        [Authorize(Roles = "Admin")]
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
        [Authorize(Roles = "Admin")]
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
