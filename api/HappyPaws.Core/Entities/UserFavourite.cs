using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class UserFavourite : BaseEntity
    {
        public User User { get; set; } = null!;
        public int UserId { get; set; }

        public Product Product { get; set; } = null!;
        public int ProductId { get; set; }
    }
}
