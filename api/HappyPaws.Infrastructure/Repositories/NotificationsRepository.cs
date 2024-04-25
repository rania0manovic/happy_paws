using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Other;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class NotificationsRepository : BaseRepository<Notification, int, NotificationSearchObject>, INotificationsRepository
    {
        public NotificationsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override Task<PagedList<Notification>> GetPagedAsync(NotificationSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return DbSet.Where(x => x.UserId == searchObject.UserId).OrderByDescending(x=>x.CreatedAt)
               .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
