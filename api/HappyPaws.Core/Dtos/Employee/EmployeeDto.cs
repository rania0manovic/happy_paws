using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Enums;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Employee
{
    public class EmployeeDto:UserBaseDto
    {
        public EmployeePosition EmployeePosition { get; set; }

        public IFormFile? PhotoFile { get; set; }
    }
}
