using HappyPaws.Core.Dtos.OrderDetail;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Mappings
{
    public class OrderDetailProfile:BaseProfile
    {
        public OrderDetailProfile()
        {
            CreateMap<OrderDetail, OrderDetailDto>().ReverseMap();
        }
    }
}
