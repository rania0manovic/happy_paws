using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class Notification : BaseEntity
    {
        public required string Title { get; set; }
        public required string Message { get; set; }
        public bool Seen { get; set; }

        public required User User { get; set; }
        public int UserId { get; set; }
    }
}
