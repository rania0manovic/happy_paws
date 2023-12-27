using HappyPaws.Core.Dtos.UserCart;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IUserCartsService : IBaseService<int, UserCartDto>
    {
    }
}
