using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Employee;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class EmployeesController : BaseCrudController<EmployeeDto, IEmployeesService>
    {
        public EmployeesController(IEmployeesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
