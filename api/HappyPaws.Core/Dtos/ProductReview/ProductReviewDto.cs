using HappyPaws.Core.Dtos.Product;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.ProductReview
{
    public class ProductReviewDto:BaseDto
    {
        public int Review { get; set; }
        public required string Note { get; set; }

        public required ProductDto Product { get; set; }
        public int ProductId { get; set; }
    }
}
