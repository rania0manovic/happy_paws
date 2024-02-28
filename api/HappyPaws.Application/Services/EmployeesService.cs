using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Employee;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class EmployeesService : BaseService<Employee, EmployeeDto, IEmployeesRepository, EmployeeSearchObject>, IEmployeesService
    {
        public EmployeesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<EmployeeDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
