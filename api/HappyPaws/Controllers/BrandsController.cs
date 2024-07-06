using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Brand;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class BrandsController : BaseCrudController<BrandDto, IBrandsService, BrandSearchObject>
    {
        public BrandsController(IBrandsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [Authorize(Policy = "AllVerified")]
        public override Task<IActionResult> GetPaged([FromQuery] BrandSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return base.GetPaged(searchObject, cancellationToken);
        }
        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Get(int id, CancellationToken cancellationToken = default)
        {
            return base.Get(id, cancellationToken);
        }
        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Post([FromBody] BrandDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }
        [Authorize(Roles = "Admin")]
        public override Task<IActionResult> Put([FromBody] BrandDto upsertDto, CancellationToken cancellationToken = default)
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
