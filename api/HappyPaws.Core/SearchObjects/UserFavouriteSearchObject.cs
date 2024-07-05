using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.SearchObjects
{
    public class UserFavouriteSearchObject : BaseSearchObject
    {
        public List<int>? RecommendedProductIds { get; set; }
        public bool? LowestPriceFirst { get; set; }
        public int? MinReview { get; set; }
    }
}
