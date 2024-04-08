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
    public class PetAllergyConfiguration : BaseConfiguration<PetAllergy>
    {
        public override void Configure(EntityTypeBuilder<PetAllergy> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.AllergySeverity).IsRequired().HasDefaultValue(AllergySeverity.Mild);
            builder.Property(x => x.Name).IsRequired();

            builder.HasOne(x => x.Pet).WithMany(x => x.PetAllergies).HasForeignKey(x => x.PetId).IsRequired();

        }
    }
}
