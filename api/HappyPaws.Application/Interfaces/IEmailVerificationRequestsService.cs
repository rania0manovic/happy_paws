using HappyPaws.Core.Dtos.EmailVerificationRequest;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IEmailVerificationRequestsService : IBaseService<int, EmailVerificationRequestDto, BaseSearchObject>
    {
        Task<bool> VerifyCodeAsync(EmailVerificationRequestDto emailVerificationRequest, CancellationToken cancellationToken = default);
    }
}
