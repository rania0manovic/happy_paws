using HappyPaws.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class Employee : UserBase
    {
        public EmployeePosition EmployeePosition { get; set; }
    }
}
