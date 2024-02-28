using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Employee;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class EmployeesController : BaseCrudController<EmployeeDto, IEmployeesService, EmployeeSearchObject>
    {
        public EmployeesController(IEmployeesService service, ILogger<BaseController> logger) : base(service, logger)
        {
        }
    }
}
