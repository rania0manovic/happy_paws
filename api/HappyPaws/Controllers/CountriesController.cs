using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Country;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class CountriesController : BaseCrudController<CountryDto, ICountriesService, CountrySearchObject>
    {
        public CountriesController(ICountriesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
