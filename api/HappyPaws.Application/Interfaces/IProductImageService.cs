using HappyPaws.Core.Dtos.ProductImage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IProductImageService : IBaseService<int, ProductImageDto>
    {
    }
}
