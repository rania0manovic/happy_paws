using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class ProductReviewConfiguration : BaseConfiguration<ProductReview>
    {
        public override void Configure(EntityTypeBuilder<ProductReview> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.Review).IsRequired();
            builder.Property(x => x.Note).IsRequired(false);

            builder.HasOne(x => x.Product).WithMany(x => x.ProductReviews).HasForeignKey(x => x.ProductId).IsRequired();

        }
    }
}
