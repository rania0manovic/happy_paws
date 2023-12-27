using HappyPaws.Core.Dtos.ProductSubcategory;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class ProductSubcategoryProfile : BaseProfile
    {
        public ProductSubcategoryProfile()
        {
            CreateMap<ProductSubcategory, ProductSubcategoryDto>().ReverseMap();
        }
    }
}
