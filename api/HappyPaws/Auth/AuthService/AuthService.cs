using AutoMapper;
using HappyPaws.Api.Config;
using HappyPaws.Application.Interfaces;
using HappyPaws.Common.Services.AuthService;
using HappyPaws.Common.Services.CryptoService;
using HappyPaws.Common.Services.EmailService;
using HappyPaws.Core.Dtos.EmailVerificationRequest;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Exceptions;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Models;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Api.Auth.AuthService
{
    public class AuthService : IAuthService
    {
        private readonly IUsersService _usersService;
        private readonly JwtTokenConfig _jwtTokenConfig;
        private readonly ICryptoService _cryptoService;
        private readonly IMapper _mapper;
        private readonly IEmailService _emailService;
        protected readonly IUnitOfWork UnitOfWork;
        private readonly IEmailVerificationRequestsService _emailVerificationRequestsService;


        public AuthService(IUsersService usersService, IOptions<JwtTokenConfig> jwtTokenConfig, ICryptoService cryptoService, IMapper mapper, IEmailVerificationRequestsService emailVerificationRequestsService, IEmailService emailService, IUnitOfWork unitOfWork)
        {
            _usersService = usersService;
            _jwtTokenConfig = jwtTokenConfig.Value;
            _cryptoService = cryptoService;
            _mapper = mapper;
            _emailVerificationRequestsService = emailVerificationRequestsService;
            _emailService = emailService;
            UnitOfWork = unitOfWork;
        }

        public async Task SendEmailVerificationCodeAsync(SignUpModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                await UnitOfWork.BeginTransactionAsync(cancellationToken);
                var code = CreateVerificationCode();
                var request = new EmailVerificationRequestDto()
                {
                    Email = model.Email,
                    Code = code,
                };
                await _emailVerificationRequestsService.AddAsync(request, cancellationToken);
                await _emailService.SendAsync("Verify your email", $"<p style='font-family: Calibri; margin-bottom:30px'>Hello {model.FirstName} {model.LastName},</p>\r\n<p style='font-family: Calibri'>In order to create your HappyPaws account you must verify your email address first. Here is your code: </p>\r\n<h2 style='font-family: Calibri'>{code}</h2>\r\n<p style='font-family: Calibri'>Your code will expire in 1 minute so make sure you use it right away.</p>\r\n<p style='font-family: Calibri'>For further enquiries, please feel free to contact our customer service team at happypaws_support@gmail.com.</p>\r\n<p style='font-family: Calibri;margin-top:30px'>Best regards<br/>HappyPaws Team </p><hr style='background-color:#78498d9e;border:none;height:0.5px' /><p style='font-family: Cambria'>This email is auto-generated. Please do not reply to this message.</p>\r\n", model.Email);
                await UnitOfWork.CommitTransactionAsync(cancellationToken);
            }
            catch (Exception)
            {
                await UnitOfWork.RollbackTransactionAsync(cancellationToken);
                throw;
            }
        }

        public async Task<TokenModel> SignInAsync(SignInModel model, CancellationToken cancellationToken = default)
        {
            var user = await _usersService.GetByEmailAsync(model.Email, cancellationToken) ?? throw new UserNotFoundException();
            if (!user.IsVerified)
                throw new UserNotVerifiedException();

            if (!_cryptoService.Verify(user.PasswordHash, user.PasswordSalt, model.Password))
                throw new UserWrongCredentialsException();

            return new TokenModel
            {
                Token = CreateToken(user)
            };
        }

        public async Task SignUpAsync(SignUpModel model, CancellationToken cancellationToken = default)
        {
            var user = _mapper.Map<UserSensitiveDto>(model);
            user.IsVerified = true;
            user.MyPawNumber = CreateCardNumber().ToString();
            user.PasswordSalt = _cryptoService.GenerateSalt();
            user.PasswordHash = _cryptoService.GenerateHash(model.Password!, user.PasswordSalt);
            await _usersService.AddAsync(user, cancellationToken);
        }

        public async Task<bool> VerifyEmail(EmailVerificationRequestDto model, CancellationToken cancellationToken = default)
        {
            return await _emailVerificationRequestsService.VerifyCodeAsync(model, cancellationToken);
        }

        public async Task<TokenModel> UpdateUserAsync(UserDto dto, CancellationToken cancellationToken = default)
        {
           var user = await _usersService.UpdateAsync(dto, cancellationToken);

            return new TokenModel
            {
                Token = CreateToken(user)
            };
        }

        static int CreateVerificationCode()
        {
            Random random = new();
            return random.Next(1000, 10000);
        }

        static long CreateCardNumber()
        {
            Random random = new();
            double randomDouble = random.NextDouble();
            long result = (long)(randomDouble * (9999999999999999 - 1000000000000000) + 1000000000000000);

            return result;
        }

        private string CreateToken(UserDto user)
        {
            try
            {
                var secretKey = Encoding.ASCII.GetBytes(_jwtTokenConfig.SecretKey);

                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new[]
                    {
                    new Claim(ClaimNames.Id, user.Id.ToString()),
                    new Claim(ClaimNames.FirstName, user.FirstName),
                    new Claim(ClaimNames.LastName, user.LastName),
                    new Claim(ClaimNames.MyPawNumber, user.MyPawNumber),
                    new Claim(ClaimNames.Email, user.Email),
                    new Claim(ClaimNames.Role, user.Role.ToString()),
                    new Claim(ClaimNames.Gender, user.Gender.ToString()),
                    new Claim(ClaimNames.ProfilePhotoId, user.ProfilePhotoId.ToString())
                }),
                    SigningCredentials = new SigningCredentials(
                        new SymmetricSecurityKey(secretKey),
                        SecurityAlgorithms.HmacSha512Signature
                    ),
                    Issuer = _jwtTokenConfig.Issuer,
                    Audience = _jwtTokenConfig.Audience,
                    Expires = DateTime.UtcNow.AddMinutes(_jwtTokenConfig.Duration)
                };


                var tokenHandler = new JwtSecurityTokenHandler();

                var token = tokenHandler.CreateToken(tokenDescriptor);
                return tokenHandler.WriteToken(token);
            }
            catch (Exception)
            {
                throw;
            }

        }
    }
}
