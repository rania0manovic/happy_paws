using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.SearchObjects
{
    public class ProductSearchObject:BaseSearchObject
    {
        public int? CategoryId { get; set; }
        public int? SubcategoryId { get; set; }

    }
}
