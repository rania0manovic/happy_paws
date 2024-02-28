using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.SearchObjects;

namespace HappyPaws.Api.Controllers
{
    public class PetsController : BaseCrudController<PetDto, IPetsService, PetSearchObject>
    {
        public PetsController(IPetsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
