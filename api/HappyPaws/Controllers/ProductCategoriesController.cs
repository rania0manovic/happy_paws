using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.ProductCategory;
using HappyPaws.Core.Dtos.ProductCategorySubcategory;
using HappyPaws.Core.Dtos.User;
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
        private readonly IImagesService _imagesService;
        private readonly IProductCategorySubcategoriesService _productCategorySubcategoriesService;
        public ProductCategoriesController(IProductCategoriesService service, ILogger<BaseController> logger, IMemoryCache memoryCache, IImagesService imagesService, IProductCategorySubcategoriesService productCategorySubcategoriesService) : base(service, logger)
        {
            _memoryCache = memoryCache;
            _imagesService = imagesService;
            _productCategorySubcategoriesService = productCategorySubcategoriesService;
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

        public override async Task<IActionResult> Post([FromForm] ProductCategoryDto upsertDto, CancellationToken cancellationToken = default)
        {
            if (upsertDto.AddedIds != null)
                upsertDto.AddedSubcategoryIds = upsertDto.AddedIds.Split(',').Select(int.Parse).ToList();
            var result = await Service.AddAsync(upsertDto, cancellationToken);
            if (_memoryCache.TryGetValue<PagedList<ProductCategoryDto>>("productCategories", out var productCategories))
            {
                result.PhotoFile = null;
                productCategories?.Items.Add(result);
                _memoryCache.Set("productCategories", productCategories, TimeSpan.FromDays(1));
            }
            else
            {
                _memoryCache.Set("productCategories", result, TimeSpan.FromDays(1));
            }
            return Ok(result);
        }
        public override Task<IActionResult> Delete(int id, CancellationToken cancellationToken = default)
        {
            if (_memoryCache.TryGetValue<PagedList<ProductCategoryDto>>("productCategories", out var productCategories))
            {
                productCategories?.Items.RemoveAll(x => x.Id == id);
                _memoryCache.Set("productCategories", productCategories, TimeSpan.FromDays(1));
            }
            return base.Delete(id, cancellationToken);
        }

        public override async Task<IActionResult> Put([FromForm] ProductCategoryDto upsertDto, CancellationToken cancellationToken = default)
        {
            try
            {
                if (upsertDto.RemovedIds != null)
                    upsertDto.RemovedSubcategoryIds = upsertDto.RemovedIds.Split(',').Select(int.Parse).ToList();
                if (upsertDto.AddedIds != null)
                    upsertDto.AddedSubcategoryIds = upsertDto.AddedIds.Split(',').Select(int.Parse).ToList();
                var result = await Service.UpdateAsync(upsertDto, cancellationToken);
                if (_memoryCache.TryGetValue<PagedList<ProductCategoryDto>>("productCategories", out var productCategories))
                {
                    var dto = productCategories?.Items.FirstOrDefault(x => x.Id == result.Id);
                    if (dto != null)
                    {
                        if (upsertDto.PhotoFile != null)
                        {
                            var photo = await _imagesService.GetByIdAsync(dto.PhotoId, cancellationToken);
                            dto.Photo = photo;
                        }
                        dto.Name = result.Name;

                    }
                    _memoryCache.Set("productCategories", productCategories, TimeSpan.FromDays(1));
                }
                string cacheKey = $"SubcategoriesForCategory_{upsertDto.Id}_includePhotos_{false}";
                var response = await _productCategorySubcategoriesService.GetSubcategoriesForCategoryAsync(upsertDto.Id, false, cancellationToken);
                _memoryCache.Set(cacheKey, response, TimeSpan.FromDays(1));
                return Ok(result);
            }
            catch (Exception)
            {
                return BadRequest();
            }
        }
    }
}
