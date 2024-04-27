using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Models;

namespace HappyPaws.Application.Services
{
    public class UsersService : BaseService<User, UserDto, IUsersRepository, UserSearchObject>, IUsersService
    {

        public UsersService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserDto> validator) : base(mapper, unitOfWork, validator)
        {
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

        public override async Task<UserDto> UpdateAsync(UserDto dto, CancellationToken cancellationToken = default)
        {
            var user = await CurrentRepository.GetByIdAsync(dto.Id, cancellationToken) ?? throw new Exception("User not found");

            if (dto.PhotoFile != null)
            {
                var memoryStream = new MemoryStream();
                await dto.PhotoFile.CopyToAsync(memoryStream, cancellationToken);
                if (user.ProfilePhotoId != null)
                {
                    var photo = await UnitOfWork.ImagesRepository.GetByIdAsync((int)user.ProfilePhotoId, cancellationToken);

                    photo!.ContentType = dto.PhotoFile.ContentType;
                    photo.Data = memoryStream.ToArray();
                    UnitOfWork.ImagesRepository.Update(photo);
                    await UnitOfWork.SaveChangesAsync(cancellationToken);

                }
                else
                {
                    var photo = new Image()
                    {
                        ContentType = dto.PhotoFile.ContentType,
                        Data = memoryStream.ToArray(),
                    };
                    await UnitOfWork.ImagesRepository.AddAsync(photo, cancellationToken);
                    await UnitOfWork.SaveChangesAsync(cancellationToken);
                    dto.ProfilePhotoId = photo.Id;
                }
            }
            Mapper.Map(dto, user);
            user.IsVerified = true;
            CurrentRepository.Update(user);
            await UnitOfWork.SaveChangesAsync(cancellationToken);
            return Mapper.Map<UserDto>(user);
        }
    }
}
