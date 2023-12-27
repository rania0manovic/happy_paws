using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Pet;

namespace HappyPaws.Api.Controllers
{
    public class PetsController : BaseCrudController<PetDto, IPetsService>
    {
        public PetsController(IPetsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
