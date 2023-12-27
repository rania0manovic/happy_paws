using HappyPaws.Core.Dtos.ProductCategorySubcategory;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class ProductCategorySubcategoryProfile:BaseProfile
    {
        public ProductCategorySubcategoryProfile()
        {
            CreateMap<ProductCategorySubcategory, ProductCategorySubcategoryDto>().ReverseMap();

        }
    }
}
