using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.SearchObjects;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Interfaces
{
    public interface IDonationsRepository : IBaseRepository<Donation, int, DonationSearchObject>
    {
        Task<double> GetAmountForMonthAsync(int month, CancellationToken cancellationToken = default);
    }
}
