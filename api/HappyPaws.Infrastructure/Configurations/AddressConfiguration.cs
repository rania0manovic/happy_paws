﻿using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class AddressConfiguration : BaseConfiguration<Address>
    {
        public override void Configure(EntityTypeBuilder<Address> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.AddressOne).IsRequired().HasMaxLength(128);
            builder.Property(x => x.AddressTwo).IsRequired(false).HasMaxLength(128);
            builder.Property(x => x.PostalCode).IsRequired().HasMaxLength(32);
            builder.Property(x => x.Note).IsRequired(false).HasMaxLength(128);

            builder.HasOne(x => x.City).WithMany(x => x.Addresses).HasForeignKey(x => x.CityId).IsRequired();

        }
    }
}
