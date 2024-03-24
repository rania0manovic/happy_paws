using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Employee
{
    public class EmployeeSensitiveDto:EmployeeDto
    {
        public required string PasswordHash { get; set; }
        public required string PasswordSalt { get; set; }
    }
}
