using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.SearchObjects
{
    public class ProductSearchObject : BaseSearchObject
    {
        public int? CategoryId { get; set; }
        public int? SubcategoryId { get; set; }
        public string? SearchParams { get; set; }
        public int TakePhotos { get; set; } = 6;
        public bool OnlyActive { get; set; } = false;
        public List<int>? RecommendedProductIds { get; set; }
        public bool GetReviews { get; set; } = true;

    }
}
