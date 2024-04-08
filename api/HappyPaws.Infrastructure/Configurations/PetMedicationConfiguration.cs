using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class PetMedicationConfiguration:BaseConfiguration<PetMedication>
    {
        public override void Configure(EntityTypeBuilder<PetMedication> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.MedicationName).IsRequired().HasMaxLength(128);
            builder.Property(e => e.DosageFrequency).IsRequired();
            builder.Property(e => e.Dosage).IsRequired();
            builder.Property(e => e.Until).IsRequired();

            builder.HasOne(x => x.Pet).WithMany(x => x.PetMedications).HasForeignKey(x => x.PetId).IsRequired(true);


        }
    }
}
