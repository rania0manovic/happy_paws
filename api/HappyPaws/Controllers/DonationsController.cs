using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Donation;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class DonationsController : BaseCrudController<DonationDto, IDonationsService, DonationSearchObject>
    {
        public DonationsController(IDonationsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
        [Authorize(Roles = "User")]
        public override Task<IActionResult> Post([FromBody] DonationDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }
    }
}
