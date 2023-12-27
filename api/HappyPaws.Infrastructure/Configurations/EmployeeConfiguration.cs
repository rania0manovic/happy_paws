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
    public class EmployeeConfiguration : BaseConfiguration<Employee>
    {
        public override void Configure(EntityTypeBuilder<Employee> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.FirstName).IsRequired().HasMaxLength(32);
            builder.Property(e => e.LastName).IsRequired().HasMaxLength(32);
            builder.Property(e => e.Email).IsRequired().HasMaxLength(128);
            builder.Property(e => e.PasswordHash).IsRequired().HasMaxLength(256);
            builder.Property(e => e.PasswordSalt).IsRequired().HasMaxLength(256);
            builder.Property(e => e.Role).IsRequired().HasDefaultValue(Role.User);
            builder.Property(e => e.Gender).IsRequired().HasDefaultValue(Gender.Unknown);
            builder.Property(e => e.EmployeePosition).IsRequired();

            builder.HasOne(x => x.ProfilePhoto).WithMany(x => x.Employees).HasForeignKey(x => x.ProfilePhotoId).IsRequired(false);
        }
    }
}
