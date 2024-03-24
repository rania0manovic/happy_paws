using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Common.Services.CryptoService;
using HappyPaws.Common.Services.EmailService;
using HappyPaws.Core.Dtos.Employee;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using System.Text;

namespace HappyPaws.Application.Services
{
    public class EmployeesService : BaseService<Employee, EmployeeDto, IEmployeesRepository, EmployeeSearchObject>, IEmployeesService
    {
        private readonly ICryptoService _cryptoService;
        private readonly IEmailService _emailService;
        public EmployeesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<EmployeeDto> validator, IEmailService emailService, ICryptoService cryptoService) : base(mapper, unitOfWork, validator)
        {
            _emailService = emailService;
            _cryptoService = cryptoService;
        }
        public override async Task<EmployeeDto> AddAsync(EmployeeDto dto, CancellationToken cancellationToken = default)
        {

            var employee = Mapper.Map<EmployeeSensitiveDto>(dto);
            if (dto.PhotoFile != null)
            {
                var memoryStream = new MemoryStream();
                await dto.PhotoFile.CopyToAsync(memoryStream, cancellationToken);

                var photo = new Image()
                {
                    ContentType = dto.PhotoFile.ContentType,
                    Data = memoryStream.ToArray(),
                };
                await UnitOfWork.ImagesRepository.AddAsync(photo, cancellationToken);
                await UnitOfWork.SaveChangesAsync(cancellationToken);
                employee.ProfilePhotoId = photo.Id;
            }
            var password = GenerateRandomPassword(8);
            employee.Role = Core.Enums.Role.Employee;
            employee.PasswordSalt = _cryptoService.GenerateSalt();
            employee.PasswordHash = _cryptoService.GenerateHash(password, employee.PasswordSalt);
            await _emailService.SendAsync("Welcome to Happy Paws", $"<p style='font-family: Calibri; margin-bottom:30px'>Hello {employee.FirstName} {employee.LastName},</p>\r\n<p style='font-family: Calibri'>We are happy to welcome you to our platform. Your account has been successfully created. Here is your temporary password: </p>\r\n<h2 style='font-family: Calibri'>{password}</h2>\r\n<p style='font-family: Calibri'>Please remember to change your password once you sign in for the first time in your profile settings.</p>\r\n<p style='font-family: Calibri'>For further enquiries, please feel free to contact our customer service team at happypaws_support@gmail.com.</p>\r\n<p style='font-family: Calibri;margin-top:30px'>Best regards<br/>HappyPaws Team </p><hr style='background-color:#78498d9e;border:none;height:0.5px' /><p style='font-family: Cambria'>This email is auto-generated. Please do not reply to this message.</p>\r\n", employee.Email);
            return await base.AddAsync(employee, cancellationToken);
        }
        public override async Task<EmployeeDto> UpdateAsync(EmployeeDto dto, CancellationToken cancellationToken = default)
        {
            var employee =await CurrentRepository.GetByIdAsync(dto.Id, cancellationToken) ?? throw new Exception("Employee not found");
            Mapper.Map(dto, employee);
            if (dto.PhotoFile != null)
            {
                var memoryStream = new MemoryStream();
                await dto.PhotoFile.CopyToAsync(memoryStream, cancellationToken);
                if (dto.ProfilePhotoId != null)
                {
                    var photo = await UnitOfWork.ImagesRepository.GetByIdAsync((int)dto.ProfilePhotoId, cancellationToken);

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
                    employee.ProfilePhotoId = photo.Id;
                }
            }
            CurrentRepository.Update(employee);
            await UnitOfWork.SaveChangesAsync(cancellationToken);
            return dto;
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

        public async Task<PagedList<EmployeeDto>> FindFreeEmployeesAsync(EmployeeSearchObject searchObject, CancellationToken cancellationToken)
        {
            return Mapper.Map<PagedList<EmployeeDto>>(await CurrentRepository.FindFreeEmployeesAsync(searchObject, cancellationToken));   
        }
    }

}
