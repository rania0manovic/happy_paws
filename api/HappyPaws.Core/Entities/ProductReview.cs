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

        public required Product Product { get; set; }
        public int ProductId { get; set; }
    }
}
