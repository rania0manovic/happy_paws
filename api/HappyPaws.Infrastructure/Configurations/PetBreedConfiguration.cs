using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class PetBreedConfiguration : BaseConfiguration<PetBreed>
    {
        public override void Configure(EntityTypeBuilder<PetBreed> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.Name).IsRequired().HasMaxLength(64);

            builder.HasOne(x => x.PetType).WithMany(x => x.PetBreeds).HasForeignKey(x => x.PetTypeId).IsRequired();
        }
    }
}
