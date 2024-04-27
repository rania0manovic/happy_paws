using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Helpers
{
    public class AnalyticsDto
    {
        public int AppUsersCount { get; set; }
        public int PatientsCount { get; set; }
        public int EmployeesCount { get; set; }
        public int DonationsTotal { get; set; }

    }
}
