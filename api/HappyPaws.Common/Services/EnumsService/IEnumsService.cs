using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Common.Services.EnumsService
{
    public interface IEnumsService
    {
        Task<IEnumerable<KeyValuePair<int, string>>> GetEmployeePositionsAsync(CancellationToken cancellationToken=default);
        Task<IEnumerable<KeyValuePair<int, string>>> GetOrderStatusesAsync(CancellationToken cancellationToken=default);
        Task<IEnumerable<KeyValuePair<int, string>>> GetNewsletterTopics(CancellationToken cancellationToken=default);
    }
}
