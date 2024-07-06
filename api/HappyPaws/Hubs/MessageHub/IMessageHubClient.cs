namespace HappyPaws.Api.Hubs.MessageHub
{
    public interface IMessageHubClient
    {
        Task SendAsync(string methodName, string user, string message);
        Task SendMessageToUser(string methodName, string userId, string message);
    }
}
