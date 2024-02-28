using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.PetType;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class PetTypesController : BaseCrudController<PetTypeDto, IPetTypesService, PetTypeSearchObject>
    {
        public PetTypesController(IPetTypesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
