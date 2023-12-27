using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Enums
{
    public enum OrderStatus
    {
        Pending,
        Processing,
        Confirmed,
        Dispatched,
        ReadyToPickUp,
        Delivered,
        Returned,
        Refunded,
        OnHold,
        Backordered

    }
}
