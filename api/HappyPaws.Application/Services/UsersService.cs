using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Helpers;
using HappyPaws.Application.Interfaces;
using HappyPaws.Common.Services.CryptoService;
using HappyPaws.Common.Services.EmailService;
using HappyPaws.Common.Services.RecommenderSystemService;
using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Dtos.UserFavourite;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Models;
using System.Text;

namespace HappyPaws.Application.Services
{
    public class UsersService : BaseService<User, UserDto, IUsersRepository, UserSearchObject>, IUsersService
    {
        private readonly IEmailService _emailService;
        private readonly ICryptoService _cryptoService;
        private readonly IRecommenderSystemService _recommenderSystemService;

        public UsersService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserDto> validator, IEmailService emailService, ICryptoService cryptoService, IRecommenderSystemService recommenderSystemService) : base(mapper, unitOfWork, validator)
        {
            _emailService = emailService;
            _cryptoService = cryptoService;
            _recommenderSystemService = recommenderSystemService;
        }

        public async Task<UserSensitiveDto> GetByEmailAsync(string email, CancellationToken cancellationToken = default)
        {
            var user = await CurrentRepository.GetByEmailAsync(email, cancellationToken);
            return Mapper.Map<UserSensitiveDto>(user);
        }

        public async Task<string?> GetConnectionId(int userId, CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.GetConnectionId(userId, cancellationToken);
        }

        public async Task<int> GetCountByRoleAsync(Role role, CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.GetCountByRoleAsync(role, cancellationToken);
        }

        public override async Task<UserDto> AddAsync(UserDto dto, CancellationToken cancellationToken = default)
        {
            if (dto.EmployeePosition != null)
            {
                var user = Mapper.Map<UserSensitiveDto>(dto);
                var password = GenerateRandomPassword(8);
                user.PasswordSalt = _cryptoService.GenerateSalt();
                user.PasswordHash = _cryptoService.GenerateHash(password, user.PasswordSalt);
                user.IsVerified = true;
                await _emailService.SendAsync("Welcome to Happy Paws", $"<p style='font-family: Calibri; margin-bottom:30px'>Hello {dto.FirstName} {dto.LastName},</p>\r\n<p style='font-family: Calibri'>We are happy to welcome you to our platform. Your account has been successfully created. Here is your temporary password: </p>\r\n<h2 style='font-family: Calibri'>{password}</h2>\r\n<p style='font-family: Calibri'>Please remember to change your password once you sign in for the first time in your profile settings.</p>\r\n<p style='font-family: Calibri'>For further enquiries, please feel free to contact our customer service team at happypaws_support@gmail.com.</p>\r\n<p style='font-family: Calibri;margin-top:30px'>Best regards<br/>HappyPaws Team </p><hr style='background-color:#78498d9e;border:none;height:0.5px' /><p style='font-family: Cambria'>This email is auto-generated. Please do not reply to this message.</p>\r\n", user.Email);
                if (dto.DownloadURL != null)
                {
                    var photo = new Image()
                    {
                        DownloadURL = dto.DownloadURL,
                    };
                    await UnitOfWork.ImagesRepository.AddAsync(photo, cancellationToken);
                    await UnitOfWork.SaveChangesAsync(cancellationToken);
                    user.ProfilePhotoId = photo.Id;
                }
                user.Role = Role.Employee;
                return await base.AddAsync(user, cancellationToken);
            }
            else return await base.AddAsync(dto, cancellationToken);
        }

        public override async Task<UserDto> UpdateAsync(UserDto dto, CancellationToken cancellationToken = default)
        {
            var user = await CurrentRepository.GetByIdAsync(dto.Id, cancellationToken) ?? throw new Exception("User not found");

            if (dto.DownloadURL != null)
            {
                if (dto.ProfilePhotoId != null)
                {
                    dto.ProfilePhoto ??= Mapper.Map<ImageDto>(user.ProfilePhoto);
                    dto.ProfilePhoto.DownloadURL = dto.DownloadURL;
                }
                else
                {
                    var photo = new Image()
                    {
                        DownloadURL = dto.DownloadURL,
                    };
                    await UnitOfWork.ImagesRepository.AddAsync(photo, cancellationToken);
                    dto.ProfilePhotoId = photo.Id;
                    dto.ProfilePhoto = Mapper.Map<ImageDto>(photo);

                }
                await UnitOfWork.SaveChangesAsync(cancellationToken);
            }
            Mapper.Map(dto, user);
            user.IsVerified = true;
            CurrentRepository.Update(user);
            await UnitOfWork.SaveChangesAsync(cancellationToken);
            return Mapper.Map<UserDto>(user);
        }

        public async Task<PagedList<UserDto>> FindFreeEmployeesAsync(EmployeeSearchObject searchObject, CancellationToken cancellationToken)
        {
            return Mapper.Map<PagedList<UserDto>>(await CurrentRepository.FindFreeEmployeesAsync(searchObject, cancellationToken));
        }

        private static string GenerateRandomPassword(int length)
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!?@._-";
            Random random = new();
            var password = new StringBuilder();

            for (int i = 0; i < length; i++)
            {
                password.Append(chars[random.Next(chars.Length)]);
            }

            return password.ToString();
        }

        public async Task<List<ProductDto>> GetRecommendedProductsForUser(int userId, CancellationToken cancellationToken = default)
        {

            var favourites = Mapper.Map<PagedList<UserFavouriteDto>>(await UnitOfWork.UserFavouritesRepository.GetPagedAsync(new UserFavouriteSearchObject() { PageSize = 999999 }, cancellationToken));
            var recommendedProducts = _recommenderSystemService.RecommendProducts(userId, 5, favourites.Items);
            var products = await UnitOfWork.ProductsRepository.GetPagedAsync(new ProductSearchObject() { PageSize = 5, RecommendedProductIds = recommendedProducts }, cancellationToken);
            return Mapper.Map<List<ProductDto>>(products.Items);
        }
    }
}

