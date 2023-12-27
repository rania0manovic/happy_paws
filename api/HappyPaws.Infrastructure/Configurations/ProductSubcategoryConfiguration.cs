using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class ProductSubcategoryConfiguration : BaseConfiguration<ProductSubcategory>
    {
        public override void Configure(EntityTypeBuilder<ProductSubcategory> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.Name).IsRequired().HasMaxLength(64);

            builder.HasMany(x => x.ProductCategorySubcategories)
            .WithOne(x => x.ProductSubcategory)
            .HasForeignKey(x => x.ProductSubcategoryId);

        }
    }
}
