using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Address;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class AddressesController : BaseCrudController<AddressDto, IAddressesService>
    {
        public AddressesController(IAddressesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
