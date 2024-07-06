using HappyPaws.Core.Dtos.EmailVerificationRequest;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class EmailVerificationRequestsRepository : BaseRepository<EmailVerificationRequest, int, BaseSearchObject>, IEmailVerificationRequestsRepository
    {
        public EmailVerificationRequestsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async Task<EmailVerificationRequest?> VerifyCodeAsync(EmailVerificationRequestDto emailVerificationRequest, CancellationToken cancellationToken)
        {
            return await DbSet.FirstOrDefaultAsync(x => x.IsExpired == false && x.Code == emailVerificationRequest.Code && x.Email == emailVerificationRequest.Email, cancellationToken: cancellationToken);
        }
    }
}
