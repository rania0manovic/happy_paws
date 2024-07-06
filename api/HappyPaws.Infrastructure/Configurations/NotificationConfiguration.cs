using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class NotificationConfiguration : BaseConfiguration<Notification>
    {
        public override void Configure(EntityTypeBuilder<Notification> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.Message).IsRequired();
            builder.Property(x => x.Title).IsRequired();
            builder.Property(x => x.Seen).IsRequired().HasDefaultValue(false);

            builder.HasOne(x => x.User).WithMany(x => x.Notifications).HasForeignKey(x => x.UserId).IsRequired();
        }
    }
}
