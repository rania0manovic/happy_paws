using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Common.Services.EmailService
{
    public class EmailService : IEmailService
    {
        private readonly string _host;
        private readonly int _port;
        private readonly int _timeout;
        private readonly string _username;
        private readonly string _password;
        private readonly string _displayName;
        private readonly string _fromAddress;
        private readonly bool _enableSSL;

        public EmailService(IConfiguration configuration)
        {
            _host = configuration["SMTP:Host"]!;
            _port = int.Parse(configuration["SMTP:Port"]!);
            _timeout = int.Parse(configuration["SMTP:Timeout"]!);
            _username = configuration["SMTP:Username"]!;
            _password = configuration["SMTP:Password"]!;
            _enableSSL = bool.Parse(configuration["SMTP:EnableSSL"]!);
            _displayName = configuration["SMTP:MailMessage:DisplayName"]!;
            _fromAddress = configuration["SMTP:MailMessage:FromAddress"]!;
        }

        public async Task Send(string subject, string body, string toAddress, Attachment? attachment = null)
        {
            await Send(subject, body, new[] { toAddress }, attachment);
        }

        public async Task Send(string subject, string body, string[] toAddresses, Attachment? attachment = null)
        {
            try
            {
                using (var smtpClient = new SmtpClient
                {
                    Port = _port,
                    Host = _host,
                    Timeout = 2000,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(_username, _password),
                    EnableSsl = _enableSSL
                })
                {
                    foreach (var address in toAddresses)
                    {
                        var mailMessage = new MailMessage(new MailAddress(_fromAddress, _displayName), new MailAddress(address))
                        {
                            Subject = subject,
                            Body = body,
                            IsBodyHtml = true,
                            BodyEncoding = Encoding.UTF8,
                            DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure
                        };

                        if (attachment != null)
                        {
                            mailMessage.Attachments.Add(attachment);
                        }

                        await smtpClient.SendMailAsync(mailMessage);
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }


        }
    }
}
