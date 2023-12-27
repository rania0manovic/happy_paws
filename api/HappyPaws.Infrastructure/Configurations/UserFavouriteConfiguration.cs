using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Configurations
{
    public class UserFavouriteConfiguration : BaseConfiguration<UserFavourite>
    {
        public override void Configure(EntityTypeBuilder<UserFavourite> builder)
        {
            base.Configure(builder);

            builder.HasOne(x => x.User).WithMany(x => x.UserFavouriteItems).HasForeignKey(x => x.UserId).IsRequired();
            builder.HasOne(x => x.Product).WithMany(x => x.UserFavouriteItems).HasForeignKey(x => x.ProductId).IsRequired();


        }
    }
}
