﻿using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.User;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.ProductReview
{
    public class ProductReviewDto : BaseDto
    {
        public int Review { get; set; }
        public string? Note { get; set; }

        public ProductDto? Product { get; set; }
        public int ProductId { get; set; }

        public UserDto? Reviewer { get; set; }
        public int ReviewerId { get; set; }
    }
}
