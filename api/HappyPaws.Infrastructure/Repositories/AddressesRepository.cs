using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class AddressesRepository : BaseRepository<Address, int>, IAddressesRepository
    {
        public AddressesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
