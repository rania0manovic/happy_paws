using HappyPaws.Core.Dtos.ProductReview;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class ProductReviewProfile : BaseProfile
    {
        public ProductReviewProfile()
        {
            CreateMap<ProductReview, ProductReviewDto>().ReverseMap();
        }
    }
}
