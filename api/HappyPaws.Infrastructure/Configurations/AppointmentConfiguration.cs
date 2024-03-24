using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class AppointmentConfiguration : BaseConfiguration<Appointment>
    {
        public override void Configure(EntityTypeBuilder<Appointment> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.Reason).IsRequired().HasMaxLength(512);
            builder.Property(x => x.Note).IsRequired(false).HasMaxLength(256);
            builder.Property(x => x.StartDateTime).IsRequired(false);
            builder.Property(x => x.EndDateTime).IsRequired(false);

            builder.HasOne(x => x.Pet).WithMany(x => x.Appointments).HasForeignKey(x => x.PetId).IsRequired();
        }
    }
}
