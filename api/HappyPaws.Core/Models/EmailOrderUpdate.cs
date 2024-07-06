using HappyPaws.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Models
{
    public class EmailOrderUpdate
    {
        public OrderStatus OrderStatus { get; set; }
        public int OrderId { get; set; }
    }
}
