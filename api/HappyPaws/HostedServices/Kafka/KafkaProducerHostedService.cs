using Confluent.Kafka;
using HappyPaws.Core.Dtos.Image;
using Newtonsoft.Json;
using System.Text;

namespace HappyPaws.Api.HostedServices.Kafka
{
    public class KafkaProducerHostedService : IHostedService, IDisposable
    {
        private readonly IProducer<Null, string> _producer;
        private readonly ILogger<KafkaProducerHostedService> _logger;

        public KafkaProducerHostedService(ILogger<KafkaProducerHostedService> logger)
        {
            _logger = logger;

            var config = new ProducerConfig
            {
                BootstrapServers = Environment.GetEnvironmentVariable("KAFKA_BROKER_URL"),
            };

            _producer = new ProducerBuilder<Null, string>(config).Build();
        }

        public Task StartAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("Kafka producer service started.");
            return Task.CompletedTask;

        }

        public Task StopAsync(CancellationToken cancellationToken)
        {
            _producer?.Dispose();
            _logger.LogInformation("Kafka producer service stopped.");
            return Task.CompletedTask;
        }

        public async Task SendMessageAsync(string topic, object obj)
        {
            try
            {
                var serializedMessage = JsonConvert.SerializeObject(obj, new JsonSerializerSettings
                {
                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                });

                await _producer.ProduceAsync(topic, new Message<Null, string>
                {
                    Value = serializedMessage
                });

                _producer.Flush(TimeSpan.FromSeconds(5));
                _logger.LogInformation($"Sent message: {serializedMessage} to topic: {topic}");
            }
            catch (ProduceException<Null, string> ex)
            {
                _logger.LogError($"Failed to produce message: {ex.Error.Reason}");
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError($"An unexpected error occurred: {ex.Message}");
                throw;
            }
        }

        public void Dispose()
        {
            _producer?.Dispose();
        }
    }
}
