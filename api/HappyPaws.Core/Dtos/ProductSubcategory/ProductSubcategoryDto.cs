using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.Dtos.ProductCategory;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.ProductSubcategory
{
    public class ProductSubcategoryDto:BaseDto
    {
        public required string Name { get; set; }

        public ImageDto? Photo { get; set; }
        public int PhotoId { get; set; }

        public IFormFile? PhotoFile { get; set; }
    }
}
