using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.City;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class CititesController : BaseCrudController<CityDto, ICitiesService>
    {
        public CititesController(ICitiesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
