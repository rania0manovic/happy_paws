using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class ProductCategoryConfiguration : BaseConfiguration<ProductCategory>
    {
        public override void Configure(EntityTypeBuilder<ProductCategory> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.Name).IsRequired().HasMaxLength(64);

            builder.HasMany(x => x.ProductCategorySubcategories)
           .WithOne(x => x.ProductCategory)
           .HasForeignKey(x => x.ProductCategoryId);

        }
    }
}
