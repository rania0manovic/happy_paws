using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.EmailVerificationRequest;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Services
{
    public class EmailVerificationRequestsService : BaseService<EmailVerificationRequest, EmailVerificationRequestDto, IEmailVerificationRequestsRepository, BaseSearchObject>, IEmailVerificationRequestsService
    {
        public EmailVerificationRequestsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<EmailVerificationRequestDto> validator) : base(mapper, unitOfWork, validator)
        {
        }

        public async Task<bool> VerifyCodeAsync(EmailVerificationRequestDto emailVerificationRequest, CancellationToken cancellationToken = default)
        {
            var result = await CurrentRepository.VerifyCodeAsync(emailVerificationRequest, cancellationToken);
            if (result == null)
                return false;
            TimeSpan timespan = DateTime.Now - result.CreatedAt;
            result.IsExpired = true;
            UnitOfWork.EmailVerificationRequestsRepository.Update(result);
            if (timespan.TotalSeconds > 60)
            {
                return false;
            }
            return true;
        }
    }
}
