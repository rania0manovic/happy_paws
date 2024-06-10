using HappyPaws.Core.Dtos.EmailVerificationRequest;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Infrastructure.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace HappyPaws.Common.Services.AuthService
{
    public interface IAuthService
    {
        Task<TokenModel> SignInAsync(SignInModel model, CancellationToken cancellationToken = default);
        Task SignUpAsync(SignUpModel model, CancellationToken cancellationToken = default);
        Task SendEmailVerificationCodeAsync(SignUpModel model, CancellationToken cancellationToken = default);
        Task<bool> VerifyEmail(EmailVerificationRequestDto model, CancellationToken cancellationToken = default);
        Task<TokenModel> UpdateUserAsync(UserDto model, CancellationToken cancellationToken = default);
        Task UpdatePasswordAsync(ChangePasswordModel model, CancellationToken cancellationToken = default);

    }
}
