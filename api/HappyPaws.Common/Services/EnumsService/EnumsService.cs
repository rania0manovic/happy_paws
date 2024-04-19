using HappyPaws.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Common.Services.EnumsService
{
    public class EnumsService : IEnumsService
    {
        public Task<IEnumerable<KeyValuePair<int, string>>> GetEmployeePositionsAsync(CancellationToken cancellationToken = default)
        {
            return Task.FromResult(GetValues<EmployeePosition>());
        }

        public Task<IEnumerable<KeyValuePair<int, string>>> GetOrderStatusesAsync(CancellationToken cancellationToken = default)
        {
            return Task.FromResult(GetValues<OrderStatus>());
        }

        private IEnumerable<KeyValuePair<int, string>> GetValues<T>() where T : Enum
        {
            return Enum.GetValues(typeof(T))
                       .Cast<int>()
                       .Select(e => new KeyValuePair<int, string>(e, Enum.GetName(typeof(T), e)!));
        }
    }
}
