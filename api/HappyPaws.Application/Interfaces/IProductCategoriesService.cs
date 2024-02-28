using HappyPaws.Core.Dtos.ProductCategory;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IProductCategoriesService:IBaseService<int,ProductCategoryDto, ProductCategorySearchObject>
    {
    }
}
