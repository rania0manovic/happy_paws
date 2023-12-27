using HappyPaws.Core.Dtos.EmailVerificationRequest;
using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Interfaces
{
    public interface IEmailVerificationRequestsRepository : IBaseRepository<EmailVerificationRequest, int>
    {
        Task<EmailVerificationRequest?> VerifyCodeAsync(EmailVerificationRequestDto emailVerificationRequest, CancellationToken cancellationToken);
    }
}
