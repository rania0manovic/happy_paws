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
    public class UserCartConfiguration : BaseConfiguration<UserCart>
    {
        public override void Configure(EntityTypeBuilder<UserCart> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.Quantity).IsRequired().HasDefaultValue(1);

            builder.HasOne(x => x.User).WithMany(x => x.UserCartItems).HasForeignKey(x => x.UserId).IsRequired();
            builder.HasOne(x => x.Product).WithMany(x => x.UserCartItems).HasForeignKey(x => x.ProductId).IsRequired();
        }
    }
}
