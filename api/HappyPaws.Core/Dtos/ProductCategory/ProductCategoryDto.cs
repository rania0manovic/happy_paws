using HappyPaws.Core.Dtos.Image;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.ProductCategory
{
    public class ProductCategoryDto:BaseDto
    {
        public required string Name { get; set; }

        public ImageDto? Photo { get; set; } 
        public int PhotoId { get; set; }

        public IFormFile? PhotoFile { get; set; }
        public String? AddedIds { get; set; }
        public String? RemovedIds { get; set; }
        public List<int>? AddedSubcategoryIds { get; set; }
        public List<int>? RemovedSubcategoryIds { get; set; }

    }
}
