﻿using HappyPaws.Core.Dtos.ProductCategory;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class ProductCategoryProfile : BaseProfile
    {
        public ProductCategoryProfile()
        {
            CreateMap<ProductCategory, ProductCategoryDto>().ReverseMap();
        }
    }
}
