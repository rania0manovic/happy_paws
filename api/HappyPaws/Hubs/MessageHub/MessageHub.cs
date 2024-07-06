using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Application.Interfaces;
using Microsoft.AspNetCore.SignalR;

namespace HappyPaws.Api.Hubs.MessageHub
{
    public class MessageHub : Hub
    {
        private readonly CurrentUser _user;
        private readonly IUsersService _usersService;
        public MessageHub(CurrentUser user, IUsersService usersService)
        {
            _user = user;
            _usersService = usersService;
        }
        public override async Task OnConnectedAsync()
        {
            var connectionId = Context.ConnectionId;
            var userId = _user.Id;
            if (connectionId != null && userId != null)
            {
                var user = await _usersService.GetByIdAsync((int)userId);
                user.ConnectionId = connectionId;
                await _usersService.UpdateAsync(user);
            }
            await base.OnConnectedAsync();
        }

        public override async Task OnDisconnectedAsync(Exception? exception)
        {
            var connectionId = Context.ConnectionId;
            var userId = _user.Id;
            if (connectionId != null && userId != null)
            {
                var user = await _usersService.GetByIdAsync((int)userId);
                user.ConnectionId = null;
                await _usersService.UpdateAsync(user);
            }
            await base.OnDisconnectedAsync(exception);
        }
    }
}
