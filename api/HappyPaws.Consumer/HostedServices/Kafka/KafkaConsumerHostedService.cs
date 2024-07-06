using Confluent.Kafka;
using HappyPaws.Common.Services.EmailService;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Infrastructure.Models;
using Newtonsoft.Json;

namespace HappyPaws.Consumer.HostedServices.Kafka
{
    public class KafkaConsumerHostedService : IHostedService, IDisposable
    {
        private readonly ILogger<KafkaConsumerHostedService> _logger;
        private readonly ConsumerConfig _consumerConfig;
        private readonly IConsumer<Null, string> _consumer;
        private readonly IEmailService _emailService;
        public KafkaConsumerHostedService(ILogger<KafkaConsumerHostedService> logger, IEmailService emailService)
        {
            _logger = logger;
            _consumerConfig = new ConsumerConfig
            {
                BootstrapServers = Environment.GetEnvironmentVariable("KAFKA_BROKER_URL"),
                GroupId = "my-consumer-group",
                AutoOffsetReset = AutoOffsetReset.Earliest
            };

            _consumer = new ConsumerBuilder<Null, string>(_consumerConfig).Build();
            _emailService = emailService;
        }

        public async Task StartAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("Kafka consumer service started.");
            _consumer.Subscribe("promote-new-products");
            await ConsumeMessagesAsync(cancellationToken);
        }

        private async Task ConsumeMessagesAsync(CancellationToken cancellationToken)
        {
            try
            {

                while (!cancellationToken.IsCancellationRequested)
                {
                    var consumeResult = _consumer.Consume(cancellationToken);
                    switch (consumeResult.Topic)
                    {
                        case "promote-new-products":
                            await SendEmailForNewArrivalsAsync(consumeResult.Message);
                            break;
                        default:
                            _logger.LogWarning($"Received message from unknown topic: {consumeResult.Topic}");
                            break;
                    }
                    _logger.LogInformation($"Received message: {consumeResult.Message.Value}");
                    Task.Delay(1000, cancellationToken).Wait(cancellationToken);
                }
            }
            catch (OperationCanceledException)
            {
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error consuming message: {ex.Message}");
            }
            finally
            {
                _consumer.Close();
            }
        }

        public Task StopAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("Kafka consumer service stopped.");
            return Task.CompletedTask;
        }

        public void Dispose()
        {
            _consumer.Dispose();
            GC.SuppressFinalize(this);
        }
        private async Task SendEmailForNewArrivalsAsync(Message<Null, string> message)
        {
            var obj = JsonConvert.DeserializeObject<PromoteProductsToUsers>(message.Value);

            string html = @"
    <!DOCTYPE html>
    <html lang=""en"">
    <head>
        <meta charset=""UTF-8"">
        <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">
        <title>New Arrivals</title>
        <style>
        .body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
        }
        .title {
            color: #3F0D84;
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .table {
            width: 100%;
            border-spacing: 10px;
            border-collapse: separate;
        }
        .item {
            background-color: #ffffff;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .item img {
            max-width: 100px;
            max-height: 100px;
            width: auto;
            height: auto;
            border-radius: 5px;
        }
        .item .price {
            font-size: 16px;
            font-weight: bold;
            color: #333333;
            margin-top: 10px;
        }
        </style>
    </head>
    <body>
        <div class=""body"">
            <div class=""container"">
                <div class=""title"">New arrivals in our shop!</div>
                <table class=""table"">
                    <tr>";
            foreach (var product in obj?.Products)
            {
                html += $@"
                        <td class=""item"">
                            <img src=""{product.ProductImages?.FirstOrDefault()?.Image?.DownloadURL}"" alt=""Product image"">
                            <div class=""price"">${product.Price}</div>
                        </td>";
            }
            html += @"
                    </tr>
                </table>
                <p>Visit our shop on the mobile app for more info!</p>
            </div>
        </div>
    </body>
    </html>";


            string[] users = obj.UserEmails;
            await _emailService.SendGroupAsync("New arrivals in our shop!", html, users);
        }


    }
}
