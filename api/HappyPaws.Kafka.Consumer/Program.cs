using Kafka.Public;
using Kafka.Public.Loggers;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System.Text;

class Program
{
    static void Main(string[] args)
    {
        CreateHostBuilder(args).Build().Run();
    }
    private static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args).ConfigureServices((contect, colleciton) =>
        {
            colleciton.AddHostedService<KafkaConsumerHostedService>();
        });


}
public class KafkaConsumerHostedService : IHostedService
{
    public ILogger<KafkaConsumerHostedService> Logger { get; }
    private ClusterClient _cluster;

    public KafkaConsumerHostedService(ILogger<KafkaConsumerHostedService> logger)
    {
        Logger = logger;
        _cluster = new ClusterClient(new Configuration
        {
            Seeds = "localhost:9092"
        }, new ConsoleLogger());
    }



    public Task StartAsync(CancellationToken cancellationToken)
    {
        _cluster.ConsumeFromLatest("demo");
        _cluster.MessageReceived += record =>
        {
            Logger.LogInformation(message: "Recieved: " + Encoding.UTF8.GetString(record.Value as byte[]));
        };
        return Task.CompletedTask;

    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        _cluster?.Dispose();
        return Task.CompletedTask;
    }
}