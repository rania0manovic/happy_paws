using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Address;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class AddressesController : BaseCrudController<AddressDto, IAddressesService,AddressSearchObject>
    {
        public AddressesController(IAddressesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
