using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class OrderConfiguration:BaseConfiguration<Order>
    {
        public override void Configure(EntityTypeBuilder<Order> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.OrderDate).IsRequired();
            builder.Property(x => x.Status).IsRequired().HasDefaultValue(OrderStatus.Pending);
            builder.Property(x => x.PaymentMethod).IsRequired();
            builder.Property(x => x.Shipping).IsRequired(false);
            builder.Property(x => x.Total).IsRequired();

            builder.HasOne(x=>x.ShippingAddress).WithMany(x=>x.Orders).HasForeignKey(x=>x.ShippingAddressId).IsRequired();
            builder.HasOne(x=>x.User).WithMany(x=>x.Orders).HasForeignKey(x=>x.UserId).IsRequired();
        }
    }
}
