using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Donation;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class DonationsController : BaseCrudController<DonationDto, IDonationsService, DonationSearchObject>
    {
        public DonationsController(IDonationsService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
