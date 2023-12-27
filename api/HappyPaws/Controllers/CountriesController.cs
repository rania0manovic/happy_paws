using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Country;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class CountriesController : BaseCrudController<CountryDto, ICountriesService>
    {
        public CountriesController(ICountriesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
