using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class PetConfiguration : BaseConfiguration<Pet>
    {
        public override void Configure(EntityTypeBuilder<Pet> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.Name).IsRequired().HasMaxLength(32);
            builder.Property(x => x.BirthDate).IsRequired();
            builder.Property(x => x.Weight).IsRequired();

            builder.HasOne(x => x.Owner).WithMany(x => x.Pets).HasForeignKey(x => x.OwnerId).IsRequired();
            builder.HasOne(x => x.PetBreed).WithMany(x => x.Pets).HasForeignKey(x => x.PetBreedId).IsRequired();
            builder.HasOne(x => x.Photo).WithMany(x => x.Pets).HasForeignKey(x => x.PhotoId).IsRequired(false);


        }
    }
}
