﻿using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.User;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.UserFavourite
{
    public class UserFavouriteDto:BaseDto
    {
        public required UserDto User { get; set; }
        public int UserId { get; set; }

        public required ProductDto Product { get; set; }
        public int ProductId { get; set; }
    }
}
