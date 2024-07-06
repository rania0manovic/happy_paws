using HappyPaws.Core.Dtos.Product;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Models
{
    public class PromoteProductsToUsers
    {
        public string[] UserEmails { get; set; } = null!;
        public List<ProductDto> Products { get; set; } = null!;
    }
}
