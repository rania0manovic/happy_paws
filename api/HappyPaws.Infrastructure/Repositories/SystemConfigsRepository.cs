﻿using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class SystemConfigsRepository : BaseRepository<SystemConfig, int, SystemConfigSearchObject>, ISystemConfigsRepository
    {
        public SystemConfigsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
