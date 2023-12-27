using HappyPaws.Core.Dtos.ProductImage;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class ProductImageProfile : BaseProfile
    {
        public ProductImageProfile()
        {
            CreateMap<ProductImage, ProductImageDto>().ReverseMap();
        }
    }
}
