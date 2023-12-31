﻿using HappyPaws.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class User : UserBase
    {
        public required string MyPawNumber { get; set; }
        public bool IsVerified { get; set; }

        public required ICollection<Order> Orders { get; set; }
        public required ICollection<Pet> Pets { get; set; }
        public required ICollection<UserCart> UserCartItems { get; set; }
        public required ICollection<UserFavourite> UserFavouriteItems { get; set; }


    }
}
