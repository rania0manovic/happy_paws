using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class ProductCategorySubcategoryConfiguration : BaseConfiguration<ProductCategorySubcategory>
    {
        public override void Configure(EntityTypeBuilder<ProductCategorySubcategory> builder)
        {
            base.Configure(builder);

            builder.HasOne(pcs => pcs.ProductCategory)
           .WithMany(pc => pc.ProductCategorySubcategories)
           .HasForeignKey(pcs => pcs.ProductCategoryId);

            builder.HasOne(pcs => pcs.ProductSubcategory)
           .WithMany(psc => psc.ProductCategorySubcategories)
           .HasForeignKey(pcs => pcs.ProductSubcategoryId);

        }
    }
}
