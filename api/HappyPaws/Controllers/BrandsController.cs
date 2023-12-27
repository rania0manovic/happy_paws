using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Brand;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class BrandsController : BaseCrudController<BrandDto, IBrandsService>
    {
        public BrandsController(IBrandsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
