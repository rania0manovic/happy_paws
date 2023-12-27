using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Employee;
using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class EmployeesService : BaseService<Employee, EmployeeDto, IEmployeesRepository>, IEmployeesService
    {
        public EmployeesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<EmployeeDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
