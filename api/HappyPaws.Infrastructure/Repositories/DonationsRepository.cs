using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class DonationsRepository : BaseRepository<Donation, int, DonationSearchObject>, IDonationsRepository
    {
        public DonationsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public async Task<double> GetAmountForMonthAsync(int month, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x => x.CreatedAt.Month == month
                && x.CreatedAt.Year == DateTime.Now.Year)
                .SumAsync(x => x.Amount, cancellationToken);
        }
    }
}
