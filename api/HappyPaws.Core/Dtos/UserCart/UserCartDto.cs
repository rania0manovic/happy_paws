using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.User;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.UserCart
{
    public class UserCartDto:BaseDto
    {
        public int Quantity { get; set; } = 1;

        public UserDto ? User { get; set; } 
        public int UserId { get; set; }

        public ProductDto ? Product { get; set; } 
        public int ProductId { get; set; }

    }
}
