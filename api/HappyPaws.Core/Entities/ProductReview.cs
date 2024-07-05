using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class ProductReview:BaseEntity
    {
        public int Review { get; set; }
        public string? Note { get; set; }

        public Product Product { get; set; } = null!;
        public int ProductId { get; set; }

        public User Reviewer { get; set; } = null!;
        public int ReviewerId { get; set; }
    }
}
