using HappyPaws.Common.Services.EmailService;
using HappyPaws.Consumer.HostedServices.Kafka;

var builder = Host.CreateDefaultBuilder(args);

builder.ConfigureServices((context, services) =>
{
    services.AddScoped<IEmailService, EmailService>();
    services.AddHostedService<KafkaConsumerHostedService>();
});


var host = builder.Build();
await host.RunAsync();