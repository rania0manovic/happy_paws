using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Common.Services.EmailService
{
    public interface IEmailService
    {
        Task Send(string subject, string body, string toAddress, Attachment? attachment = null);
        Task Send(string subject, string body, string[] toAddresses, Attachment? attachment = null);
    }
}
