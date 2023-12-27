using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetType;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class PetTypesController : BaseCrudController<PetTypeDto, IPetTypesService>
    {
        public PetTypesController(IPetTypesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
