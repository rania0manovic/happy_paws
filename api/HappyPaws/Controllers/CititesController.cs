using HappyPaws.Api.Hubs.MessageHub;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.City;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;

namespace HappyPaws.Api.Controllers
{
    public class CititesController : BaseCrudController<CityDto, ICitiesService, CitySearchObject>
    {
        private readonly IHubContext<MessageHub> _hubContext;
        private readonly IUsersService _usersService;

        public CititesController(ICitiesService service, ILogger<BaseController> logger, IHubContext<MessageHub> hubContext, IUsersService usersService) : base(service, logger)
        {
            _hubContext = hubContext;
            _usersService = usersService;
        }

        public override async Task<IActionResult> GetPaged([FromQuery] CitySearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var connectionId = await _usersService.GetConnectionId(8, cancellationToken);
            if (connectionId == null) { return NotFound(); }
            await _hubContext.Clients.Client(connectionId).SendAsync("ReceiveMessage", "Hello user 8", cancellationToken: cancellationToken);
            return Ok();
        }
    }

}
