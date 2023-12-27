using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class UserFavourite : BaseEntity
    {
        public required User User { get; set; }
        public int UserId { get; set; }

        public required Product Product { get; set; }
        public int ProductId { get; set; }
    }
}
