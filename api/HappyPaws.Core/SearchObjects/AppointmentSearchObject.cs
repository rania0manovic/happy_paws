using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.SearchObjects
{
    public class AppointmentSearchObject:BaseSearchObject
    {
        public int? EmployeeId { get; set; }
        public int? AppointmentId { get; set; }
        public DateTime? Date { get; set; }
        public DateTime? MinDateTime { get; set; }
        public DateTime? StartDateTime { get; set; }
        public DateTime? EndDateTime { get; set; }

    }
}
