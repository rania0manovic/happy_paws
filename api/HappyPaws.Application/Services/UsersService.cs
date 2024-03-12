using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Entities;
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

        public override async Task<UserDto> UpdateAsync(UserDto dto, CancellationToken cancellationToken = default)
        {
            var user = await CurrentRepository.GetByIdAsync(dto.Id, cancellationToken) ?? throw new Exception("User not found");
           
            Mapper.Map(dto, user);
            CurrentRepository.Update(user);
            await UnitOfWork.SaveChangesAsync(cancellationToken);

            return Mapper.Map<UserDto>(user);
        }
    }
}
