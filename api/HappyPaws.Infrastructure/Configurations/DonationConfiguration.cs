using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class DonationConfiguration : BaseConfiguration<Donation>
    {
        public override void Configure(EntityTypeBuilder<Donation> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.Amount).IsRequired();

            builder.HasOne(x => x.User).WithMany(x => x.Donations).HasForeignKey(x => x.UserId).IsRequired();

        }
    }
}
