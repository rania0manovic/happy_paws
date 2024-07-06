using HappyPaws.Core.Dtos.Donation;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IDonationsService : IBaseService<int, DonationDto, DonationSearchObject>
    {
        Task<double> GetAmountForMonthAsync(int month, CancellationToken cancellationToken = default);
    }
}
