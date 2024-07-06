using HappyPaws.Core.Entities;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography.X509Certificates;
using System.Threading;

namespace HappyPaws.Infrastructure
{
    public partial class DatabaseContext : DbContext
    {

        public DbSet<Appointment> Appointments { get; set; }
        public DbSet<Brand> Brands { get; set; }
        public DbSet<Image> Images { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetail> OrderDetails { get; set; }
        public DbSet<Pet> Pets { get; set; }
        public DbSet<PetAllergy> PetAllergies { get; set; }
        public DbSet<PetMedication> PetMedications { get; set; }
        public DbSet<PetBreed> PetBreeds { get; set; }
        public DbSet<PetType> PetTypes { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<ProductCategory> ProductCategories { get; set; }
        public DbSet<ProductImage> ProductImages { get; set; }
        public DbSet<ProductReview> ProductReviews { get; set; }
        public DbSet<ProductSubcategory> ProductSubcategories { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<UserAddress> UserAddresses { get; set; }
        public DbSet<UserCart> UserCarts { get; set; }
        public DbSet<UserFavourite> UserFavourites { get; set; }
        public DbSet<EmailVerificationRequest> EmailVerificationRequests { get; set; }
        public DbSet<ProductCategorySubcategory> ProductCategorySubcategories { get; set; }
        public DbSet<Notification> Notifications { get; set; }
        public DbSet<Donation> Donations { get; set; }
        public DbSet<SystemConfig> SystemConfigs { get; set; }

        public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            ApplyConfigurations(modelBuilder);
            SeedData(modelBuilder);
        }

    }
}
