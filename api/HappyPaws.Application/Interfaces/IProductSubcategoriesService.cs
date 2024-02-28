using HappyPaws.Core.Dtos.ProductSubcategory;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IProductSubcategoriesService : IBaseService<int, ProductSubcategoryDto, ProductSubcategorySearchObject>
    {
    }
}
