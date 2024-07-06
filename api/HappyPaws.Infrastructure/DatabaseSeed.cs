using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure
{
    public partial class DatabaseContext
    {
        private readonly DateTime _dateTime = DateTime.Now;

        public void SeedData(ModelBuilder modelBuilder)
        {
            SeedUsers(modelBuilder);
            SeedPetTypes(modelBuilder);
            SeedPetBreeds(modelBuilder);
            SeedPets(modelBuilder);
            SeedProductCategories(modelBuilder);
            SeedProductSubcategories(modelBuilder);
            SeedProductCategorySubcategories(modelBuilder);
            SeedSystemConfigs(modelBuilder);
            SeedBrands(modelBuilder);
            SeedProducts(modelBuilder);
            SeedReviews(modelBuilder);
            SeedUserAddresses(modelBuilder);
            SeedOrders(modelBuilder);
            SeedOrderDetails(modelBuilder);
            SeedUserFavourites(modelBuilder);
            SeedAppointments(modelBuilder);
        }

        private void SeedAppointments(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Appointment>().HasData(
                new Appointment
                {
                    Id = 1,
                    Reason = "Behavioral changes",
                    Note = "Eats less and sleeps more",
                    PetId = 1,
                    CreatedAt = _dateTime.AddDays(-1)
                },
                new Appointment
                {
                    Id = 2,
                    Reason = "Regular health check-up",
                    PetId = 2,
                    CreatedAt = _dateTime.AddHours(-10)
                },
                new Appointment
                {
                    Id = 3,
                    Reason = "Skin issues",
                    Note = "Itching and hair loss",
                    PetId = 5,
                    CreatedAt = _dateTime.AddHours(-6)
                },
                new Appointment
                {
                    Id = 4,
                    Reason = "Pregnancy",
                    PetId = 6,
                    CreatedAt = _dateTime.AddHours(-4)
                },
                new Appointment
                {
                    Id = 5,
                    Reason = "Vaccination and check-up",
                    PetId = 13,
                    CreatedAt = _dateTime.AddHours(-2)
                }
                );
        }
        private void SeedUserFavourites(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserFavourite>().HasData(
            new UserFavourite
            {
                Id = 1,
                CreatedAt = _dateTime,
                UserId = 2,
                ProductId = 1,
            },
            new UserFavourite
            {
                Id = 2,
                CreatedAt = _dateTime,
                UserId = 3,
                ProductId = 1,
            },
            new UserFavourite
            {
                Id = 3,
                CreatedAt = _dateTime,
                UserId = 4,
                ProductId = 1,
            },
            new UserFavourite
            {
                Id = 4,
                CreatedAt = _dateTime,
                UserId = 2,
                ProductId = 5,
            },
            new UserFavourite
            {
                Id = 5,
                CreatedAt = _dateTime,
                UserId = 3,
                ProductId = 5,
            },
            new UserFavourite
            {
                Id = 6,
                CreatedAt = _dateTime,
                UserId = 3,
                ProductId = 11,
            },
            new UserFavourite
            {
                Id = 7,
                CreatedAt = _dateTime,
                UserId = 3,
                ProductId = 30,
            },
            new UserFavourite
            {
                Id = 8,
                CreatedAt = _dateTime,
                UserId = 4,
                ProductId = 33,
            },
            new UserFavourite
            {
                Id = 9,
                CreatedAt = _dateTime,
                UserId = 4,
                ProductId = 9,
            },
            new UserFavourite
            {
                Id = 10,
                CreatedAt = _dateTime,
                UserId = 2,
                ProductId = 2,
            },
            new UserFavourite
            {
                Id = 11,
                CreatedAt = _dateTime,
                UserId = 2,
                ProductId = 48,
            },
            new UserFavourite
            {
                Id = 12,
                CreatedAt = _dateTime,
                UserId = 3,
                ProductId = 48,
            },
            new UserFavourite
            {
                Id = 13,
                CreatedAt = _dateTime,
                UserId = 4,
                ProductId = 48,
            }
            );
        }
        private void SeedOrderDetails(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<OrderDetail>().HasData(
             new OrderDetail
             {
                 Id = 1,
                 CreatedAt = _dateTime,
                 OrderId = 483641,
                 ProductId = 1,
                 Quantity = 1,
                 UnitPrice = 10.99,
             },
             new OrderDetail
             {
                 Id = 2,
                 CreatedAt = _dateTime,
                 OrderId = 483641,
                 ProductId = 2,
                 Quantity = 1,
                 UnitPrice = 10,
             },
             new OrderDetail
             {
                 Id = 3,
                 CreatedAt = _dateTime,
                 OrderId = 483642,
                 ProductId = 14,
                 Quantity = 2,
                 UnitPrice = 3.99,
             },
             new OrderDetail
             {
                 Id = 4,
                 CreatedAt = _dateTime,
                 OrderId = 483642,
                 ProductId = 15,
                 Quantity = 4,
                 UnitPrice = 3.99,
             },
             new OrderDetail
             {
                 Id = 5,
                 CreatedAt = _dateTime,
                 OrderId = 483643,
                 ProductId = 26,
                 Quantity = 4,
                 UnitPrice = 3.49,
             },
             new OrderDetail
             {
                 Id = 6,
                 CreatedAt = _dateTime,
                 OrderId = 483643,
                 ProductId = 31,
                 Quantity = 4,
                 UnitPrice = 3.49,
             },
             new OrderDetail
             {
                 Id = 7,
                 CreatedAt = _dateTime,
                 OrderId = 483643,
                 ProductId = 3,
                 Quantity = 2,
                 UnitPrice = 12
             },
             new OrderDetail
             {
                 Id = 8,
                 CreatedAt = _dateTime,
                 OrderId = 483644,
                 ProductId = 21,
                 Quantity = 2,
                 UnitPrice = 19.99
             },
             new OrderDetail
             {
                 Id = 9,
                 CreatedAt = _dateTime,
                 OrderId = 483645,
                 ProductId = 5,
                 Quantity = 1,
                 UnitPrice = 15
             },
             new OrderDetail
             {
                 Id = 10,
                 CreatedAt = _dateTime,
                 OrderId = 483645,
                 ProductId = 10,
                 Quantity = 1,
                 UnitPrice = 13.99
             },
             new OrderDetail
             {
                 Id = 11,
                 CreatedAt = _dateTime,
                 OrderId = 483645,
                 ProductId = 11,
                 Quantity = 4,
                 UnitPrice = 1.99
             }
             );
        }
        private void SeedOrders(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Order>().HasData(
                new Order
                {
                    Id = 483641,
                    CreatedAt = _dateTime.AddDays(-9),
                    PaymentMethod = PaymentMethod.InStore,
                    Status = OrderStatus.Delivered,
                    UserId = 2,
                    Total = 20.99,
                },
                new Order
                {
                    Id = 483642,
                    CreatedAt = _dateTime.AddDays(-7),
                    PaymentMethod = PaymentMethod.InStore,
                    Status = OrderStatus.Delivered,
                    UserId = 3,
                    Total = 23.94,
                },
                new Order
                {
                    Id = 483643,
                    CreatedAt = _dateTime.AddHours(-6),
                    PaymentMethod = PaymentMethod.InStore,
                    Status = OrderStatus.Pending,
                    UserId = 2,
                    Total = 51.92,
                },
                new Order
                {
                    Id = 483644,
                    CreatedAt = _dateTime.AddHours(-1),
                    PaymentMethod = PaymentMethod.InStore,
                    Status = OrderStatus.Pending,
                    UserId = 4,
                    Total = 39.98,
                },
                new Order
                {
                    Id = 483645,
                    CreatedAt = _dateTime,
                    PaymentMethod = PaymentMethod.InStore,
                    Status = OrderStatus.Pending,
                    UserId = 2,
                    Total = 36.95,
                }
                );
        }
        private void SeedUserAddresses(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserAddress>().HasData(
                new UserAddress
                {
                    Id = 1,
                    UserId = 2,
                    AddressOne = "Test address 1",
                    City = "Mostar",
                    Country = "Bosnia and Herzegowina",
                    FullName = "Emily Johnson",
                    Phone = "061 222 333",
                    PostalCode = "88000",
                    CreatedAt = _dateTime,
                    IsInitialUserAddress = true,
                });
        }
        private void SeedUsers(ModelBuilder modelBuilder)
        {
            Random random = new();
            modelBuilder.Entity<User>().HasData(
                new User
                {
                    Id = 1,
                    FirstName = "Main",
                    LastName = "Admin",
                    Email = "admin@happypaws.com",
                    Role = Role.Admin,
                    Gender = Gender.Female,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    IsVerified = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                },
                 new User
                 {
                     Id = 2,
                     FirstName = "Emily",
                     LastName = "Johnson",
                     Email = "user@happypaws.com",
                     Role = Role.User,
                     Gender = Gender.Unknown,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     IsVerified = true,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     MyPawNumber = ((long)(random.NextDouble() * 9_000_000_000_000_000) + 1_000_000_000_000_000).ToString(),
                 },
                 new User
                 {
                     Id = 3,
                     FirstName = "Sophia",
                     LastName = "Williams",
                     Email = "sophia.williams@happypaws.com",
                     Role = Role.User,
                     Gender = Gender.Female,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     IsVerified = true,
                     CreatedAt = _dateTime,
                     MyPawNumber = ((long)(random.NextDouble() * 9_000_000_000_000_000) + 1_000_000_000_000_000).ToString(),
                     ModifiedAt = null,
                 },
                  new User
                  {
                      Id = 4,
                      FirstName = "Michael",
                      LastName = "Martinez",
                      Email = "michael.martinez@happypaws.com",
                      Role = Role.User,
                      Gender = Gender.Male,
                      PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                      PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                      IsVerified = true,
                      CreatedAt = _dateTime,
                      MyPawNumber = ((long)(random.NextDouble() * 9_000_000_000_000_000) + 1_000_000_000_000_000).ToString(),
                      ModifiedAt = null,
                  },
                 new User
                 {
                     Id = 5,
                     FirstName = "Olivia",
                     LastName = "Taylor",
                     Email = "olivia.taylor@happypaws.com",
                     Role = Role.User,
                     Gender = Gender.Female,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     IsVerified = true,
                     MyPawNumber = ((long)(random.NextDouble() * 9_000_000_000_000_000) + 1_000_000_000_000_000).ToString(),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                 },

                 new User
                 {
                     Id = 6,
                     FirstName = "James",
                     LastName = "Davis",
                     Email = "james.davis@happypaws.com",
                     Role = Role.User,
                     Gender = Gender.Male,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     IsVerified = true,
                     MyPawNumber = ((long)(random.NextDouble() * 9_000_000_000_000_000) + 1_000_000_000_000_000).ToString(),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                 },
                 new User
                 {
                     Id = 7,
                     FirstName = "Ava",
                     LastName = "Miller",
                     Email = "ava.miller@happypaws.com",
                     Role = Role.User,
                     Gender = Gender.Female,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     MyPawNumber = ((long)(random.NextDouble() * 9_000_000_000_000_000) + 1_000_000_000_000_000).ToString(),
                     IsVerified = true,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                 },
                 new User
                 {
                     Id = 8,
                     FirstName = "William",
                     LastName = "Anderson",
                     Email = "william.anderson@happypaws.com",
                     Role = Role.User,
                     Gender = Gender.Male,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     IsVerified = true,
                     MyPawNumber = ((long)(random.NextDouble() * 9_000_000_000_000_000) + 1_000_000_000_000_000).ToString(),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                 },
                 new
                 User
                 {
                     Id = 9,
                     FirstName = "Isabella",
                     LastName = "Wilson",
                     Email = "isabella.wilson@happypaws.com",
                     Role = Role.User,
                     Gender = Gender.Female,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     IsVerified = true,
                     MyPawNumber = ((long)(random.NextDouble() * 9_000_000_000_000_000) + 1_000_000_000_000_000).ToString(),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                 },
                 new User
                 {
                     Id = 10,
                     FirstName = "John",
                     LastName = "Smith",
                     Email = "john.smith@happypaws.com",
                     Role = Role.User,
                     Gender = Gender.Male,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     MyPawNumber = ((long)(random.NextDouble() * 9_000_000_000_000_000) + 1_000_000_000_000_000).ToString(),
                     IsVerified = true,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                 },
                new User
                {
                    Id = 11,
                    FirstName = "Emma",
                    LastName = "Collins",
                    Email = "vet@happypaws.com",
                    Role = Role.Employee,
                    Gender = Gender.Female,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    IsVerified = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    EmployeePosition = EmployeePosition.Veterinarian
                },
                new User
                {
                    Id = 12,
                    FirstName = "Liam",
                    LastName = "Roberts",
                    Email = "liam.roberts@happypaws.com",
                    Role = Role.Employee,
                    Gender = Gender.Male,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    IsVerified = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    EmployeePosition = EmployeePosition.VeterinarianTechnician
                },
                new User
                {
                    Id = 13,
                    FirstName = "Ava",
                    LastName = "Stewart",
                    Email = "ava.stewart@happypaws.com",
                    Role = Role.Employee,
                    Gender = Gender.Female,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    IsVerified = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    EmployeePosition = EmployeePosition.VeterinarianAssistant
                },
                new User
                {
                    Id = 14,
                    FirstName = "Noah",
                    LastName = "Harris",
                    Email = "noah.harris@happypaws.com",
                    Role = Role.Employee,
                    Gender = Gender.Male,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    IsVerified = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    EmployeePosition = EmployeePosition.Groomer
                },
                new User
                {
                    Id = 15,
                    FirstName = "Olivia",
                    LastName = "Clark",
                    Email = "pharmacy@happypaws.com",
                    Role = Role.Employee,
                    Gender = Gender.Female,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    IsVerified = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    EmployeePosition = EmployeePosition.PharmacyStaff
                },
                new User
                {
                    Id = 16,
                    FirstName = "William",
                    LastName = "Young",
                    Email = "william.young@happypaws.com",
                    Role = Role.Employee,
                    Gender = Gender.Male,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    IsVerified = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    EmployeePosition = EmployeePosition.MaintenanceStaff
                },
                new User
                {
                    Id = 17,
                    FirstName = "Sophia",
                    LastName = "King",
                    Email = "retail@happypaws.com",
                    Role = Role.Employee,
                    Gender = Gender.Female,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    IsVerified = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    EmployeePosition = EmployeePosition.RetailStaff
                },
                new User
                {
                    Id = 18,
                    FirstName = "James",
                    LastName = "Lee",
                    Email = "james.lee@happypaws.com",
                    Role = Role.Employee,
                    Gender = Gender.Male,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    IsVerified = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    EmployeePosition = EmployeePosition.MaintenanceStaff
                },
                new User
                {
                    Id = 19,
                    FirstName = "Isabella",
                    LastName = "Moore",
                    Email = "isabella.moore@happypaws.com",
                    Role = Role.Employee,
                    Gender = Gender.Female,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    IsVerified = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    EmployeePosition = EmployeePosition.RetailStaff
                },
                new User
                {
                    Id = 20,
                    FirstName = "Mia",
                    LastName = "Turner",
                    Email = "mia.turner@happypaws.com",
                    Role = Role.Employee,
                    Gender = Gender.Female,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    IsVerified = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    EmployeePosition = EmployeePosition.VeterinarianAssistant
                }
                );
        }
        private void SeedPetTypes(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PetType>().HasData(
                    new PetType
                    {
                        Id = 1,
                        Name = "Cat",
                        CreatedAt = _dateTime,

                    },
                    new PetType
                    {
                        Id = 2,
                        Name = "Dog",
                        CreatedAt = _dateTime,

                    },
                    new PetType
                    {
                        Id = 3,
                        Name = "Rabbit",
                        CreatedAt = _dateTime,

                    },
                    new PetType
                    {
                        Id = 4,
                        Name = "Bird",
                        CreatedAt = _dateTime,

                    },
                    new PetType
                    {
                        Id = 5,
                        Name = "Fish",
                        CreatedAt = _dateTime,

                    },
                    new PetType
                    {
                        Id = 6,
                        Name = "Hamster",
                        CreatedAt = _dateTime,

                    },
                    new PetType
                    {
                        Id = 7,
                        Name = "Guinea Pig",
                        CreatedAt = _dateTime,
                    },
                    new PetType
                    {
                        Id = 8,
                        Name = "Snake",
                        CreatedAt = _dateTime,
                    },
                    new PetType
                    {
                        Id = 9,
                        Name = "Lizard",
                        CreatedAt = _dateTime,
                    },
                    new PetType
                    {
                        Id = 10,
                        Name = "Ferret",
                        CreatedAt = _dateTime,
                    },
                    new PetType
                    {
                        Id = 11,
                        Name = "Mouse",
                        CreatedAt = _dateTime,
                    },
                    new PetType
                    {
                        Id = 12,
                        Name = "Chinchilla",
                        CreatedAt = _dateTime,
                    },
                     new PetType
                     {
                         Id = 13,
                         Name = "Turtle",
                         CreatedAt = _dateTime,
                     }
                );
        }
        private void SeedPetBreeds(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PetBreed>().HasData(
                new PetBreed { Id = 1, Name = "Persian", PetTypeId = 1, CreatedAt = _dateTime },
                new PetBreed { Id = 2, Name = "Siamese", PetTypeId = 1, CreatedAt = _dateTime },
                new PetBreed { Id = 3, Name = "Maine Coon", PetTypeId = 1, CreatedAt = _dateTime },
                new PetBreed { Id = 4, Name = "British Shorthair", PetTypeId = 1, CreatedAt = _dateTime },
                new PetBreed { Id = 5, Name = "Sphynx", PetTypeId = 1, CreatedAt = _dateTime },
                new PetBreed { Id = 6, Name = "Labrador Retriever", PetTypeId = 2, CreatedAt = _dateTime },
                new PetBreed { Id = 7, Name = "German Shepherd", PetTypeId = 2, CreatedAt = _dateTime },
                new PetBreed { Id = 8, Name = "Golden Retriever", PetTypeId = 2, CreatedAt = _dateTime },
                new PetBreed { Id = 9, Name = "French Bulldog", PetTypeId = 2, CreatedAt = _dateTime },
                new PetBreed { Id = 10, Name = "Beagle", PetTypeId = 2, CreatedAt = _dateTime },
                new PetBreed { Id = 11, Name = "Dutch", PetTypeId = 3, CreatedAt = _dateTime },
                new PetBreed { Id = 12, Name = "Holland Lop", PetTypeId = 3, CreatedAt = _dateTime },
                new PetBreed { Id = 13, Name = "Mini Rex", PetTypeId = 3, CreatedAt = _dateTime },
                new PetBreed { Id = 14, Name = "Netherland Dwarf", PetTypeId = 3, CreatedAt = _dateTime },
                new PetBreed { Id = 15, Name = "Flemish Giant", PetTypeId = 3, CreatedAt = _dateTime },
                new PetBreed { Id = 16, Name = "Budgerigar", PetTypeId = 4, CreatedAt = _dateTime },
                new PetBreed { Id = 17, Name = "Cockatiel", PetTypeId = 4, CreatedAt = _dateTime },
                new PetBreed { Id = 18, Name = "African Grey Parrot", PetTypeId = 4, CreatedAt = _dateTime },
                new PetBreed { Id = 19, Name = "Canary", PetTypeId = 4, CreatedAt = _dateTime },
                new PetBreed { Id = 20, Name = "Macaw", PetTypeId = 4, CreatedAt = _dateTime },
                new PetBreed { Id = 21, Name = "Goldfish", PetTypeId = 5, CreatedAt = _dateTime },
                new PetBreed { Id = 22, Name = "Betta", PetTypeId = 5, CreatedAt = _dateTime },
                new PetBreed { Id = 23, Name = "Guppy", PetTypeId = 5, CreatedAt = _dateTime },
                new PetBreed { Id = 24, Name = "Angelfish", PetTypeId = 5, CreatedAt = _dateTime },
                new PetBreed { Id = 25, Name = "Koi", PetTypeId = 5, CreatedAt = _dateTime },
                new PetBreed { Id = 26, Name = "Syrian Hamster", PetTypeId = 6, CreatedAt = _dateTime },
                new PetBreed { Id = 27, Name = "Dwarf Hamster", PetTypeId = 6, CreatedAt = _dateTime },
                new PetBreed { Id = 28, Name = "Roborovski Hamster", PetTypeId = 6, CreatedAt = _dateTime },
                new PetBreed { Id = 29, Name = "Chinese Hamster", PetTypeId = 6, CreatedAt = _dateTime },
                new PetBreed { Id = 30, Name = "Campbell's Dwarf Hamster", PetTypeId = 6, CreatedAt = _dateTime },
                new PetBreed { Id = 31, Name = "American Guinea Pig", PetTypeId = 7, CreatedAt = _dateTime },
                new PetBreed { Id = 32, Name = "Peruvian Guinea Pig", PetTypeId = 7, CreatedAt = _dateTime },
                new PetBreed { Id = 33, Name = "Abyssinian Guinea Pig", PetTypeId = 7, CreatedAt = _dateTime },
                new PetBreed { Id = 34, Name = "Teddy Guinea Pig", PetTypeId = 7, CreatedAt = _dateTime },
                new PetBreed { Id = 35, Name = "Silkie Guinea Pig", PetTypeId = 7, CreatedAt = _dateTime },
                new PetBreed { Id = 36, Name = "Ball Python", PetTypeId = 8, CreatedAt = _dateTime },
                new PetBreed { Id = 37, Name = "Corn Snake", PetTypeId = 8, CreatedAt = _dateTime },
                new PetBreed { Id = 38, Name = "Boa Constrictor", PetTypeId = 8, CreatedAt = _dateTime },
                new PetBreed { Id = 39, Name = "King Snake", PetTypeId = 8, CreatedAt = _dateTime },
                new PetBreed { Id = 40, Name = "Milk Snake", PetTypeId = 8, CreatedAt = _dateTime },
                new PetBreed { Id = 41, Name = "Leopard Gecko", PetTypeId = 9, CreatedAt = _dateTime },
                new PetBreed { Id = 42, Name = "Bearded Dragon", PetTypeId = 9, CreatedAt = _dateTime },
                new PetBreed { Id = 43, Name = "Crested Gecko", PetTypeId = 9, CreatedAt = _dateTime },
                new PetBreed { Id = 44, Name = "Blue-Tongued Skink", PetTypeId = 9, CreatedAt = _dateTime },
                new PetBreed { Id = 45, Name = "Green Anole", PetTypeId = 9, CreatedAt = _dateTime },
                new PetBreed { Id = 46, Name = "Standard Ferret", PetTypeId = 10, CreatedAt = _dateTime },
                new PetBreed { Id = 47, Name = "Angora Ferret", PetTypeId = 10, CreatedAt = _dateTime },
                new PetBreed { Id = 48, Name = "Sable Ferret", PetTypeId = 10, CreatedAt = _dateTime },
                new PetBreed { Id = 49, Name = "Albino Ferret", PetTypeId = 10, CreatedAt = _dateTime },
                new PetBreed { Id = 50, Name = "Black-Footed Ferret", PetTypeId = 10, CreatedAt = _dateTime },
                new PetBreed { Id = 51, Name = "House Mouse", PetTypeId = 11, CreatedAt = _dateTime },
                new PetBreed { Id = 52, Name = "Fancy Mouse", PetTypeId = 11, CreatedAt = _dateTime },
                new PetBreed { Id = 53, Name = "Lab Mouse", PetTypeId = 11, CreatedAt = _dateTime },
                new PetBreed { Id = 54, Name = "Pygmy Mouse", PetTypeId = 11, CreatedAt = _dateTime },
                new PetBreed { Id = 55, Name = "Harvest Mouse", PetTypeId = 11, CreatedAt = _dateTime },
                new PetBreed { Id = 56, Name = "Standard Chinchilla", PetTypeId = 12, CreatedAt = _dateTime },
                new PetBreed { Id = 57, Name = "Mutant Chinchilla", PetTypeId = 12, CreatedAt = _dateTime },
                new PetBreed { Id = 58, Name = "Wilson White Chinchilla", PetTypeId = 12, CreatedAt = _dateTime },
                new PetBreed { Id = 59, Name = "Black Velvet Chinchilla", PetTypeId = 12, CreatedAt = _dateTime },
                new PetBreed { Id = 60, Name = "Beige Chinchilla", PetTypeId = 12, CreatedAt = _dateTime },
                new PetBreed { Id = 61, Name = "Red-Eared Slider", PetTypeId = 13, CreatedAt = _dateTime },
                new PetBreed { Id = 62, Name = "Eastern Box Turtle", PetTypeId = 13, CreatedAt = _dateTime },
                new PetBreed { Id = 63, Name = "Painted Turtle", PetTypeId = 13, CreatedAt = _dateTime },
                new PetBreed { Id = 64, Name = "Russian Tortoise", PetTypeId = 13, CreatedAt = _dateTime },
                new PetBreed { Id = 65, Name = "Map Turtle", PetTypeId = 13, CreatedAt = _dateTime }

                );
        }
        private void SeedPets(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Pet>().HasData(
               new Pet
               {
                   Id = 1,
                   Name = "Tommy",
                   Gender = Gender.Male,
                   OwnerId = 2,
                   PetBreedId = 1,
                   Weight = 3,
                   BirthDate = _dateTime
               },
               new Pet
               {
                   Id = 2,
                   Name = "Buddy",
                   Gender = Gender.Male,
                   OwnerId = 2,
                   PetBreedId = 6,
                   Weight = 2,
                   BirthDate = _dateTime
               },
                new Pet
                {
                    Id = 3,
                    Name = "Bella",
                    Gender = Gender.Female,
                    OwnerId = 3,
                    PetBreedId = 2,
                    Weight = 5,
                    BirthDate = _dateTime
                },
                new Pet
                {
                    Id = 4,
                    Name = "Snowball",
                    Gender = Gender.Female,
                    OwnerId = 3,
                    PetBreedId = 13,
                    Weight = 1,
                    BirthDate = _dateTime
                },
                new Pet
                {
                    Id = 5,
                    Name = "Max",
                    Gender = Gender.Male,
                    OwnerId = 3,
                    PetBreedId = 16,
                    Weight = 0.2,
                    BirthDate = _dateTime
                },

                new Pet
                {
                    Id = 6,
                    Name = "Luna",
                    Gender = Gender.Female,
                    OwnerId = 4,
                    PetBreedId = 3,
                    Weight = 4,
                    BirthDate = _dateTime
                },
                new Pet
                {
                    Id = 7,
                    Name = "Charlie",
                    Gender = Gender.Male,
                    OwnerId = 4,
                    PetBreedId = 21,
                    Weight = 0.1,
                    BirthDate = _dateTime
                },

                new Pet
                {
                    Id = 8,
                    Name = "Milo",
                    Gender = Gender.Male,
                    OwnerId = 5,
                    PetBreedId = 8,
                    Weight = 7,
                    BirthDate = _dateTime
                },

                new Pet
                {
                    Id = 9,
                    Name = "Lucy",
                    Gender = Gender.Female,
                    OwnerId = 6,
                    PetBreedId = 41,
                    Weight = 0.05,
                    BirthDate = _dateTime
                },
                new Pet
                {
                    Id = 10,
                    Name = "Rocky",
                    Gender = Gender.Male,
                    OwnerId = 6,
                    PetBreedId = 36,
                    Weight = 1.5,
                    BirthDate = _dateTime
                },

                new Pet
                {
                    Id = 11,
                    Name = "Oreo",
                    Gender = Gender.Male,
                    OwnerId = 7,
                    PetBreedId = 51,
                    Weight = 0.03,
                    BirthDate = _dateTime
                },

                new Pet
                {
                    Id = 12,
                    Name = "Mittens",
                    Gender = Gender.Female,
                    OwnerId = 8,
                    PetBreedId = 62,
                    Weight = 1.2,
                    BirthDate = _dateTime
                },
                new Pet
                {
                    Id = 13,
                    Name = "Shadow",
                    Gender = Gender.Male,
                    OwnerId = 8,
                    PetBreedId = 31,
                    Weight = 0.4,
                    BirthDate = _dateTime
                },

                new Pet
                {
                    Id = 14,
                    Name = "Simba",
                    Gender = Gender.Male,
                    OwnerId = 9,
                    PetBreedId = 10,
                    Weight = 9,
                    BirthDate = _dateTime
                },
                new Pet
                {
                    Id = 15,
                    Name = "Lily",
                    Gender = Gender.Female,
                    OwnerId = 9,
                    PetBreedId = 41,
                    Weight = 0.08,
                    BirthDate = _dateTime
                },
                new Pet
                {
                    Id = 16,
                    Name = "Max",
                    Gender = Gender.Male,
                    OwnerId = 10,
                    PetBreedId = 9,
                    Weight = 2,
                    BirthDate = _dateTime
                }

                );
        }
        private void SeedProductCategories(ModelBuilder modelBuilder)
        {

            modelBuilder.Entity<Image>().HasData(
                new Image
                {
                    Id = 1,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718571880926?alt=media&token=9452f92a-f6d4-4378-a6be-ad245c627a44"
                },
                new Image
                {
                    Id = 2,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718571890300?alt=media&token=defe1580-5d1b-4606-8e7e-a527e25b5cc3"
                },
                new Image
                {
                    Id = 3,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718571904326?alt=media&token=c214401f-1e66-4b09-b045-551a24e26a21"
                },
                new Image
                {
                    Id = 4,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718571914808?alt=media&token=f218dd55-8525-4ec0-a7da-829b43979610"
                },
                new Image
                {
                    Id = 5,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572194372?alt=media&token=72cfbf3c-269b-47b3-8341-a57e33a95e81"
                },
                new Image
                {
                    Id = 6,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572203797?alt=media&token=aabc3cb5-2b8f-4f0c-85d7-04d721af205c"
                });


            modelBuilder.Entity<ProductCategory>().HasData(
                new ProductCategory
                {
                    Id = 1,
                    Name = "Cats",
                    PhotoId = 1,
                    CreatedAt = _dateTime
                },
                new ProductCategory
                {
                    Id = 2,
                    Name = "Dogs",
                    PhotoId = 2,
                    CreatedAt = _dateTime
                },
                new ProductCategory
                {
                    Id = 3,
                    Name = "Birds",
                    PhotoId = 3,
                    CreatedAt = _dateTime
                },
                new ProductCategory
                {
                    Id = 4,
                    Name = "Fish",
                    PhotoId = 4,
                    CreatedAt = _dateTime
                },
                new ProductCategory
                {
                    Id = 5,
                    Name = "Small animals",
                    PhotoId = 5,
                    CreatedAt = _dateTime
                },
                new ProductCategory
                {
                    Id = 6,
                    Name = "Other",
                    PhotoId = 6,
                    CreatedAt = _dateTime
                });
        }
        private void SeedProductSubcategories(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Image>().HasData(

              new Image
              {
                  Id = 7,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572229582?alt=media&token=e77740e8-eadf-4e89-b41e-36609caba757",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 8,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572463285?alt=media&token=75702f07-f74d-4d2e-815d-5f48ab5491f4",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 9,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572471391?alt=media&token=2eb29f60-7a0a-4a94-a4ea-e0b9203bd67e",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 10,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572479874?alt=media&token=5555d732-76e7-47af-a75c-9ef60f0d603c",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 11,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572488286?alt=media&token=42c52ab6-a70e-4c45-80f1-6a45bb27b419",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 12,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572501204?alt=media&token=2f342a96-e8a7-48a3-8ccc-129e2c1affac",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 13,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572509258?alt=media&token=23217630-22d3-4401-8f1c-1d347f084c56",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 14,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572753515?alt=media&token=621d4b83-c4db-48ad-980f-0fa2706297a8",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 15,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572519196?alt=media&token=ed519c4f-a764-4816-8ec4-450ae6b2b420",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 16,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572531782?alt=media&token=86c37db9-6bd3-4cdf-9642-6af3f94204fa",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 17,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572543532?alt=media&token=a0d40c26-ec1f-48fc-9d51-ad9ff92bc6be",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 18,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572552307?alt=media&token=d3aa85c9-c704-44f4-b04e-c97587fe2151",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 19,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572559793?alt=media&token=8fed84e5-c237-4830-b2d0-08a1a85d8def",
                  CreatedAt = _dateTime
              },
              new Image
              {
                  Id = 20,
                  DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572567952?alt=media&token=d4f4c6cd-20fe-4b00-9621-66690039bd74",
                  CreatedAt = _dateTime
              }
              );

            modelBuilder.Entity<ProductSubcategory>().HasData(
                new ProductSubcategory
                {
                    Id = 1,
                    Name = "Aquariums",
                    PhotoId = 7,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 2,
                    Name = "Beds",
                    PhotoId = 8,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 3,
                    Name = "Cages",
                    PhotoId = 9,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 4,
                    Name = "Carriers",
                    PhotoId = 10,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 5,
                    Name = "Collars",
                    PhotoId = 11,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 6,
                    Name = "Fish Flakes",
                    PhotoId = 12,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 7,
                    Name = "Food",
                    PhotoId = 13,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 8,
                    Name = "Houses",
                    PhotoId = 14,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 9,
                    Name = "Medicine",
                    PhotoId = 15,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 10,
                    Name = "Snacks",
                    PhotoId = 16,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 11,
                    Name = "Hygine",
                    PhotoId = 17,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 12,
                    Name = "Toys",
                    PhotoId = 18,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 13,
                    Name = "Treats",
                    PhotoId = 19,
                    CreatedAt = _dateTime
                },
                new ProductSubcategory
                {
                    Id = 14,
                    Name = "Other",
                    PhotoId = 20,
                    CreatedAt = _dateTime
                }

               );
        }
        private void SeedProductCategorySubcategories(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ProductCategorySubcategory>().HasData(
                new ProductCategorySubcategory { Id = 1, ProductCategoryId = 1, ProductSubcategoryId = 2, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 2, ProductCategoryId = 1, ProductSubcategoryId = 4, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 3, ProductCategoryId = 1, ProductSubcategoryId = 5, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 4, ProductCategoryId = 1, ProductSubcategoryId = 7, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 5, ProductCategoryId = 1, ProductSubcategoryId = 9, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 6, ProductCategoryId = 1, ProductSubcategoryId = 10, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 7, ProductCategoryId = 1, ProductSubcategoryId = 11, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 8, ProductCategoryId = 1, ProductSubcategoryId = 12, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 9, ProductCategoryId = 1, ProductSubcategoryId = 13, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 10, ProductCategoryId = 1, ProductSubcategoryId = 14, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 11, ProductCategoryId = 2, ProductSubcategoryId = 2, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 12, ProductCategoryId = 2, ProductSubcategoryId = 4, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 13, ProductCategoryId = 2, ProductSubcategoryId = 5, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 14, ProductCategoryId = 2, ProductSubcategoryId = 7, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 15, ProductCategoryId = 2, ProductSubcategoryId = 8, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 16, ProductCategoryId = 2, ProductSubcategoryId = 9, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 17, ProductCategoryId = 2, ProductSubcategoryId = 10, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 18, ProductCategoryId = 2, ProductSubcategoryId = 11, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 19, ProductCategoryId = 2, ProductSubcategoryId = 12, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 20, ProductCategoryId = 2, ProductSubcategoryId = 13, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 21, ProductCategoryId = 2, ProductSubcategoryId = 14, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 22, ProductCategoryId = 3, ProductSubcategoryId = 3, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 23, ProductCategoryId = 3, ProductSubcategoryId = 7, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 24, ProductCategoryId = 3, ProductSubcategoryId = 9, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 25, ProductCategoryId = 3, ProductSubcategoryId = 10, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 26, ProductCategoryId = 3, ProductSubcategoryId = 11, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 27, ProductCategoryId = 3, ProductSubcategoryId = 13, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 28, ProductCategoryId = 3, ProductSubcategoryId = 14, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 39, ProductCategoryId = 4, ProductSubcategoryId = 1, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 40, ProductCategoryId = 4, ProductSubcategoryId = 6, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 41, ProductCategoryId = 4, ProductSubcategoryId = 7, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 42, ProductCategoryId = 4, ProductSubcategoryId = 9, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 43, ProductCategoryId = 4, ProductSubcategoryId = 11, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 44, ProductCategoryId = 4, ProductSubcategoryId = 13, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 45, ProductCategoryId = 4, ProductSubcategoryId = 14, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 29, ProductCategoryId = 5, ProductSubcategoryId = 3, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 30, ProductCategoryId = 5, ProductSubcategoryId = 4, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 31, ProductCategoryId = 5, ProductSubcategoryId = 7, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 32, ProductCategoryId = 5, ProductSubcategoryId = 8, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 33, ProductCategoryId = 5, ProductSubcategoryId = 9, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 34, ProductCategoryId = 5, ProductSubcategoryId = 10, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 35, ProductCategoryId = 5, ProductSubcategoryId = 11, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 36, ProductCategoryId = 5, ProductSubcategoryId = 12, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 37, ProductCategoryId = 5, ProductSubcategoryId = 13, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 38, ProductCategoryId = 5, ProductSubcategoryId = 14, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 46, ProductCategoryId = 6, ProductSubcategoryId = 7, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 47, ProductCategoryId = 6, ProductSubcategoryId = 14, CreatedAt = _dateTime }

                );
        }
        private void SeedSystemConfigs(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<SystemConfig>().HasData(
                new SystemConfig
                {
                    Id = 1,
                    DonationsGoal = 100,
                    CreatedAt = _dateTime
                }
                );

        }
        private void SeedBrands(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Brand>().HasData(
                new Brand { Id = 1, Name = "Brit", CreatedAt = _dateTime },
                new Brand { Id = 2, Name = "Blue Buffalo", CreatedAt = _dateTime },
                new Brand { Id = 3, Name = "Hill's Science Diet", CreatedAt = _dateTime },
                new Brand { Id = 4, Name = "Purina", CreatedAt = _dateTime },
                new Brand { Id = 5, Name = "Royal Canin", CreatedAt = _dateTime },
                new Brand { Id = 6, Name = "Iams", CreatedAt = _dateTime },
                new Brand { Id = 7, Name = "Merrick", CreatedAt = _dateTime },
                new Brand { Id = 8, Name = "Taste of the Wild", CreatedAt = _dateTime },
                new Brand { Id = 9, Name = "Wellness", CreatedAt = _dateTime },
                new Brand { Id = 10, Name = "Acana", CreatedAt = _dateTime },
                new Brand { Id = 11, Name = "Orijen", CreatedAt = _dateTime },
                new Brand { Id = 12, Name = "Natural Balance", CreatedAt = _dateTime },
                new Brand { Id = 13, Name = "Earthborn Holistic", CreatedAt = _dateTime },
                new Brand { Id = 14, Name = "Diamond Naturals", CreatedAt = _dateTime },
                new Brand { Id = 15, Name = "Zignature", CreatedAt = _dateTime },
                new Brand { Id = 16, Name = "Fromm", CreatedAt = _dateTime },
                new Brand { Id = 17, Name = "Canidae", CreatedAt = _dateTime },
                new Brand { Id = 18, Name = "Nutro", CreatedAt = _dateTime },
                new Brand { Id = 19, Name = "Instinct", CreatedAt = _dateTime },
                new Brand { Id = 20, Name = "Science Diet", CreatedAt = _dateTime },
                new Brand { Id = 21, Name = "Petcurean", CreatedAt = _dateTime },
                new Brand { Id = 22, Name = "Tetra", CreatedAt = _dateTime },
                new Brand { Id = 23, Name = "GLEE", CreatedAt = _dateTime }
                );

        }
        private void SeedProducts(ModelBuilder modelBuilder)
        {
            Random random = new();
            var upc = ((long)(random.NextDouble() * 9_000_000_000_000) + 1_000_000_000_000);
            SeedProductsForCats(modelBuilder, upc);
            SeedProductsForDogs(modelBuilder, upc + 50);
            SeedProductsForFish(modelBuilder, upc + 100);

        }
        private void SeedProductsForCats(ModelBuilder modelBuilder, long upc)
        {
            modelBuilder.Entity<Image>().HasData(
                new Image
                {
                    Id = 21,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573577409?alt=media&token=4667380c-c2af-4f8a-9848-17eabef5be5e"
                },
                new Image
                {
                    Id = 22,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573675523?alt=media&token=d4f313ec-7ba2-4a88-9995-4886fec87777"

                },
                new Image
                {
                    Id = 23,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573705237?alt=media&token=beeff100-e5a4-4257-9f1b-151b79f01770"

                },
                new Image
                {
                    Id = 24,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573727398?alt=media&token=ec11af2d-8146-4599-bf14-5001cb694faa"

                },
                new Image
                {
                    Id = 25,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573748174?alt=media&token=8435ac5a-6414-44e4-a93b-6ca8530f62c8"

                },
                new Image
                {
                    Id = 26,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573772707?alt=media&token=39b108f1-c9c0-484f-a3d2-a21e4ef73ee4"

                },
                new Image
                {
                    Id = 27,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573788405?alt=media&token=b54020b0-1307-4677-ac69-2a811274681e"

                },
                new Image
                {
                    Id = 28,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573816596?alt=media&token=2824be7a-7f93-4ec5-b3e7-d9ae0d09abcb"

                },
                new Image
                {
                    Id = 29,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573834055?alt=media&token=a826219d-f27f-4ba2-b0c7-14633c4d27c0"

                },
                new Image
                {
                    Id = 30,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573851364?alt=media&token=9f2dfeec-5f64-4cf9-ade1-da4ee17505a1"

                },
                new Image
                {
                    Id = 31,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573883211?alt=media&token=71dac2f2-ea73-469f-8870-715b2f4a6a7c"
                },
                new Image
                {
                    Id = 43,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623454876?alt=media&token=b7220a38-2813-45dc-b482-3a9195c61d4e"
                },
                new Image
                {
                    Id = 44,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623476263?alt=media&token=01bd0df0-293f-40b2-964f-f4b3c6d277d1"
                },
                new Image
                {
                    Id = 45,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623498777?alt=media&token=2eb52d97-b653-4431-9a68-1e24d9d0cb49"
                },
                new Image
                {
                    Id = 46,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623517796?alt=media&token=117bbcdb-0eff-4687-a4f3-1b7aab54a522"
                },
                new Image
                {
                    Id = 47,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623548126?alt=media&token=f9938823-a187-4e57-9529-f2ac7afb7821"
                },
                new Image
                {
                    Id = 48,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623567565?alt=media&token=a27c2f7c-3bbb-46e3-940d-cc9684e70fbc"
                },
                new Image
                {
                    Id = 49,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623591139?alt=media&token=34f0e077-d64e-4d45-9d2c-a7fa15b6d27d"
                },
                new Image
                {
                    Id = 50,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623617605?alt=media&token=cfaafb23-7aee-4173-83ce-292f0bf4a8a1"
                },
                new Image
                {
                    Id = 51,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623645714?alt=media&token=5eda632e-77bd-47fb-bb22-e7dffac3a90a"
                },
                new Image
                {
                    Id = 52,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623681116?alt=media&token=86687a37-61da-4172-aaec-8484f7724913"
                },
                new Image
                {
                    Id = 53,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623704058?alt=media&token=1f20a15b-05a2-4c0a-840f-53bd0781719e"
                },
                new Image
                {
                    Id = 68,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188175265?alt=media&token=1d28bf60-d5e1-46b5-bb5b-dd7ba84a7cd3"
                },
                new Image
                {
                    Id = 69,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188226696?alt=media&token=ac3295bc-095a-4b24-ba21-60203c511991"
                },
                new Image
                {
                    Id = 70,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188271275?alt=media&token=4ea322e7-a0d8-494f-a419-9168f1720cbf"
                },
                new Image
                {
                    Id = 71,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188335655?alt=media&token=6d94b773-625c-41a0-80dc-bb75042f9a78"
                },
                new Image
                {
                    Id = 72,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188349717?alt=media&token=c836de92-44e1-4b82-8048-c91fd9f7ff06"
                },
                new Image
                {
                    Id = 73,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188375367?alt=media&token=aa8385fc-dfb7-4e33-8e05-bdbd7942eed8"
                },
                new Image
                {
                    Id = 74,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188411179?alt=media&token=0e02d3fb-b2b0-4242-a440-aab3b07c9471"
                },
                new Image
                {
                    Id = 75,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188475589?alt=media&token=cadfb3d8-4163-4a89-ba89-1ab2629b644a"
                },
                new Image
                {
                    Id = 76,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188488399?alt=media&token=5b81af29-2404-4d00-a7f8-0fffafbdaa33"
                },
                new Image
                {
                    Id = 77,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188509030?alt=media&token=dc0ec218-fe19-4228-969e-97fa07cf0052"
                },
                new Image
                {
                    Id = 78,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188535155?alt=media&token=aa57abdf-9abc-4844-a17f-0d8659f4c49a"
                },
                new Image
                {
                    Id = 79,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188586588?alt=media&token=7e18c575-283a-4d77-b12b-04dbf9b1e5d9"
                },
                new Image
                {
                    Id = 80,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188600838?alt=media&token=b26949fa-ea16-4160-a819-06242ef076ac"
                }

                );
            modelBuilder.Entity<Product>().HasData(
                new Product
                {
                    Id = 1,
                    Name = "Brit Care Cat Food Dry Sterilized Urinary Health",
                    BrandId = 1,
                    Description = "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 100,
                    Price = 10.99,
                    ProductCategorySubcategoryId = 4,
                },
                new Product
                {
                    Id = 2,
                    Name = "Brit Care Cat Food Dry Indoor",
                    BrandId = 1,
                    Description = "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 100,
                    ProductCategorySubcategoryId = 4,
                    Price = 10,
                },
                new Product
                {
                    Id = 3,
                    Name = "Brit Care Cat Dry Food Kitten",
                    BrandId = 1,
                    Description = "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 100,
                    ProductCategorySubcategoryId = 4,
                    Price = 12,
                },
                new Product
                {
                    Id = 4,
                    Name = "Brit Care Cat Dry Food Insects",
                    BrandId = 1,
                    Description = "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    ProductCategorySubcategoryId = 4,
                    InStock = 100,
                    Price = 11,
                },
                new Product
                {
                    Id = 5,
                    Name = "Brit Care Cat Dry Food Adult",
                    BrandId = 1,
                    Description = "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    ProductCategorySubcategoryId = 4,
                    InStock = 100,
                    Price = 15,
                },
                new Product
                {
                    Id = 6,
                    Name = "Brit Care Cat Dry Food Sensitive",
                    BrandId = 1,
                    Description = "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 100,
                    Price = 12,
                },
                new Product
                {
                    Id = 7,
                    Name = "Brit Care Cat Dry Haircare",
                    BrandId = 1,
                    Description = "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    ProductCategorySubcategoryId = 4,
                    InStock = 100,
                    Price = 12,
                },
                new Product
                {
                    Id = 8,
                    Name = "Brit Care Cat Dry Food Sterilized Sensitive",
                    BrandId = 1,
                    Description = "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    ProductCategorySubcategoryId = 4,
                    InStock = 100,
                    Price = 12,
                },
                new Product
                {
                    Id = 9,
                    Name = "Brit Care Cat Dry Sterilized Weight Control",
                    BrandId = 1,
                    Description = "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 100,
                    Price = 13.99,
                },
                new Product
                {
                    Id = 10,
                    Name = "Brit Care Cat Dry Sterilized Large Cats",
                    BrandId = 1,
                    Description = "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 100,
                    Price = 13.99,
                },
                new Product
                {
                    Id = 11,
                    Name = "Brit Care Cat Pouch Savory Salmon Jelly KITTEN",
                    BrandId = 1,
                    Description = "Fillets in Jelly with Savory Salmon enriched with Carrot & Rosemary. Complete superpremium wet food for Kittens.Delicate pouches for increasing the diversity of your cat’s diet, perfect for extra picky cats and cats with issues eating food. To make your cat’s belly feel even better, they also contain rosemary and carrots to support proper digestion.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 100,
                    Price = 1.99,
                },
                new Product
                {
                    Id = 23,
                    Name = "Spayed & Neutered Thin Slices in Gravy Canned Cat Food",
                    BrandId = 5,
                    Description = "Complete and balanced nutrition for cats.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.49,
                },
                new Product
                {
                    Id = 24,
                    Name = "Indoor Adult Morsels in Gravy Canned Cat Food",
                    BrandId = 5,
                    Description = "Complete and balanced nutrition for cats.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.49,
                },
                new Product
                {
                    Id = 25,
                    Name = "Weight Care Thin Slices in Gravy Canned Cat Food",
                    BrandId = 5,
                    Description = "Complete and balanced nutrition for cats.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.49,
                },
                new Product
                {
                    Id = 26,
                    Name = "Adult Instinctive Loaf in Sauce Canned Cat Food",
                    BrandId = 5,
                    Description = "Complete and balanced nutrition for cats.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.49,
                },
                new Product
                {
                    Id = 27,
                    Name = "Mother & Babycat Ultra Soft Mousse in Sauce Canned Cat Food",
                    BrandId = 5,
                    Description = "Complete and balanced nutrition for cats.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.49,
                },
                new Product
                {
                    Id = 28,
                    Name = "Mother & Babycat Ultra Soft Mousse in Sauce Canned Cat Food",
                    BrandId = 5,
                    Description = "Complete and balanced nutrition for cats.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.49,
                },
                new Product
                {
                    Id = 29,
                    Name = "Appetite Control Care Thin Slices in Gravy Canned Cat Food",
                    BrandId = 5,
                    Description = "Complete and balanced nutrition for cats.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.49,
                },
                new Product
                {
                    Id = 30,
                    Name = "Kitten Thin Slices in Gravy",
                    BrandId = 5,
                    Description = "Complete and balanced nutrition for cats.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.49,
                },
                new Product
                {
                    Id = 31,
                    Name = "Kitten Loaf in Sauce Canned Cat Food",
                    BrandId = 5,
                    Description = "Complete and balanced nutrition for cats.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.49,
                },
                new Product
                {
                    Id = 32,
                    Name = "Persian Adult Loaf in Sauce canned cat food",
                    BrandId = 5,
                    Description = "Complete and balanced nutrition for cats.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.49,
                },
                new Product
                {
                    Id = 33,
                    Name = "Digest Sensitive Thin Slices in Gravy Canned Cat Food",
                    BrandId = 5,
                    Description = "Complete and balanced nutrition for cats.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 4,
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.49,
                },
                new Product
                {
                    Id = 46,
                    Name = "Circular pouf bed",
                    BrandId = 23,
                    Description = "Comfortable beds for cats where they can relax and rest. With a very soft polyester.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 19.99,
                },
                new Product
                {
                    Id = 47,
                    Name = "Flamingo Jean blue bed",
                    BrandId = 23,
                    Description = "",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 25.49,
                },
                new Product
                {
                    Id = 48,
                    Name = "Beds Insect Protection",
                    BrandId = 23,
                    Description = "GLEE for pets beds “Insect Protection” keep your pets safe from insects & parasites since their revolutionary technology repels mosquitoes, mites, ticks, flies, fleas and other bugs that can carry dangerous illnesses such as Lyme disease and heartworm. The active ingredients permethrin-infused was tightly bonded to the fabric fibre used nanotechnology offers invisible, odorless, long-lasting, and effective protection for your dogs all year long.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 28.00,
                },
                new Product
                {
                    Id = 49,
                    Name = "Rectangular bed CATS",
                    BrandId = 23,
                    Description = "",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 23.99,
                },
                new Product
                {
                    Id = 50,
                    Name = "Rectangular bed FISHES",
                    BrandId = 23,
                    Description = "",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 23.99,
                },
                new Product
                {
                    Id = 51,
                    Name = "Rectangular bed JEAN blue",
                    BrandId = 23,
                    Description = "",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 22.00,
                },
                new Product
                {
                    Id = 52,
                    Name = "Rectangular bed terracotta",
                    BrandId = 23,
                    Description = "",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 24.49,
                },
                new Product
                {
                    Id = 53,
                    Name = "Rectangular Sofas",
                    BrandId = 23,
                    Description = "Comfortable sofas for cats with removable cushion cover.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 33.29,
                },
                new Product
                {
                    Id = 54,
                    Name = "Rectangular sofa with pattern brown",
                    BrandId = 23,
                    Description = "Comfortable sofa for cats with removable cushion cover.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 26.30,
                },
                new Product
                {
                    Id = 55,
                    Name = "Waterproof rectangular beds",
                    BrandId = 23,
                    Description = "Comfortable mattresses for and cats with removable cushion cover.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 24.99,
                },
                new Product
                {
                    Id = 56,
                    Name = "Beds OYSTER",
                    BrandId = 23,
                    Description = "Comfortable beds “THE ORIGINALS” for cats where they can relax and rest.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 29.99,
                },
                new Product
                {
                    Id = 57,
                    Name = "Circular bed brown",
                    BrandId = 23,
                    Description = "Comfortable beds “THE ORIGINALS” for cats where they can relax and rest.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 23.49,
                },
                new Product
                {
                    Id = 58,
                    Name = "Circular bed pink",
                    BrandId = 23,
                    Description = "Comfortable beds “THE ORIGINALS” for cats where they can relax and rest.",
                    UPC = (upc++).ToString(),
                    ProductCategorySubcategoryId = 1,
                    CreatedAt = _dateTime,
                    InStock = 20,
                    Price = 23.49,
                }


            );
            modelBuilder.Entity<ProductImage>().HasData(
                new ProductImage
                {
                    Id = 1,
                    ImageId = 21,
                    ProductId = 1,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 2,
                    ImageId = 22,
                    ProductId = 2,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 3,
                    ImageId = 23,
                    ProductId = 3,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 4,
                    ImageId = 24,
                    ProductId = 4,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 5,
                    ImageId = 25,
                    ProductId = 5,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 6,
                    ImageId = 26,
                    ProductId = 6,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 7,
                    ImageId = 27,
                    ProductId = 7,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 8,
                    ImageId = 28,
                    ProductId = 8,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 9,
                    ImageId = 29,
                    ProductId = 9,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 10,
                    ImageId = 30,
                    ProductId = 10,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 11,
                    ImageId = 31,
                    ProductId = 11,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 23,
                    ImageId = 43,
                    ProductId = 23,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 24,
                    ImageId = 44,
                    ProductId = 24,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 25,
                    ImageId = 45,
                    ProductId = 25,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 26,
                    ImageId = 46,
                    ProductId = 26,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 27,
                    ImageId = 47,
                    ProductId = 27,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 28,
                    ImageId = 48,
                    ProductId = 28,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 29,
                    ImageId = 49,
                    ProductId = 29,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 30,
                    ImageId = 50,
                    ProductId = 30,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 31,
                    ImageId = 51,
                    ProductId = 31,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 32,
                    ImageId = 52,
                    ProductId = 32,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 33,
                    ImageId = 53,
                    ProductId = 33,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 46,
                    ImageId = 68,
                    ProductId = 46,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 47,
                    ImageId = 69,
                    ProductId = 47,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 48,
                    ImageId = 70,
                    ProductId = 48,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 49,
                    ImageId = 71,
                    ProductId = 49,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 50,
                    ImageId = 72,
                    ProductId = 50,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 51,
                    ImageId = 73,
                    ProductId = 51,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 52,
                    ImageId = 74,
                    ProductId = 52,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 53,
                    ImageId = 75,
                    ProductId = 53,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 54,
                    ImageId = 76,
                    ProductId = 54,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 55,
                    ImageId = 77,
                    ProductId = 55,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 56,
                    ImageId = 78,
                    ProductId = 56,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 57,
                    ImageId = 79,
                    ProductId = 57,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 58,
                    ImageId = 80,
                    ProductId = 58,
                    CreatedAt = _dateTime
                }
               );
        }
        private void SeedProductsForDogs(ModelBuilder modelBuilder, long upc)
        {
            modelBuilder.Entity<Image>().HasData(
                new Image
                {
                    Id = 32,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718574227806?alt=media&token=48f261b8-b34c-483c-86ad-35bb92267c3e"
                },
                new Image
                {
                    Id = 33,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718574247502?alt=media&token=8f3ea19a-1300-4be1-bf8f-bb285525e23c"
                },
                new Image
                {
                    Id = 34,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718574275926?alt=media&token=b548245c-e59e-47c5-b9ff-35a6b285266e"
                },
                new Image
                {
                    Id = 35,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718574320317?alt=media&token=4f9122af-ac3d-46be-9bc6-1a629bd649c2"
                },
                new Image
                {
                    Id = 36,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718574343800?alt=media&token=da6bc504-ac55-4ae9-9552-26c1525304f3"
                },
                new Image
                {
                    Id = 37,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718575174572?alt=media&token=b054a3f5-2b70-48ed-922e-6e8efe356a0a"
                },
                new Image
                {
                    Id = 38,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718575192827?alt=media&token=e0753162-98e5-455d-8132-32c46fbdec4c"
                },
                new Image
                {
                    Id = 39,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718575207880?alt=media&token=367aaa4c-9b53-4796-9517-5b37f9bbab79"
                },
                new Image
                {
                    Id = 40,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718575231513?alt=media&token=ef0460cd-a83f-4d5a-9bc1-cdf7f4b634e0"
                },
                new Image
                {
                    Id = 41,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718575295800?alt=media&token=25cd953d-b3f4-449f-981c-d1e7f0199a74"
                },
                new Image
                {
                    Id = 42,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718575323931?alt=media&token=3e12eed2-edb9-4521-a9b0-ea61e183dcd8"
                }
                );


            modelBuilder.Entity<Product>().HasData(
                 new Product
                 {
                     Id = 12,
                     Name = "Brit Care Dog Crunchy Cracker Insect And Lamb",
                     BrandId = 1,
                     Description = "Functional Complementary Dog Food for Puppies.",
                     UPC = (upc++).ToString(),
                     CreatedAt = _dateTime,
                     InStock = 50,
                     Price = 3.99,
                     ProductCategorySubcategoryId = 17,
                 },
                new Product
                {
                    Id = 13,
                    Name = "Brit Care Dog Crunchy Cracker Insect And Rabbit",
                    BrandId = 1,
                    Description = "Functional Complementary Dog Food for Puppies.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 17,
                    Price = 3.99,
                },
                new Product
                {
                    Id = 14,
                    Name = "Brit Care Dog Crunchy Cracker Insect And Salmon",
                    BrandId = 1,
                    Description = "Functional Complementary Dog Food for Puppies.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 17,
                    Price = 3.99,
                },
                new Product
                {
                    Id = 15,
                    Name = "Brit Care Dog Crunchy Cracker Insect And Tuna",
                    BrandId = 1,
                    Description = "Functional Complementary Dog Food for Puppies.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 17,
                    Price = 3.99,
                },
                new Product
                {
                    Id = 16,
                    Name = "Brit Care Dog Crunchy Cracker Insect And Whey",
                    BrandId = 1,
                    Description = "Functional Complementary Dog Food for Puppies.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 17,
                    Price = 3.99,
                },
                new Product
                {
                    Id = 17,
                    Name = "ACANA Classics, Chicken and Barley Recipe",
                    BrandId = 10,
                    Description = "Help your dog feel so good inside, you’ll see it on the outside! Nurture your dog with the simple nutrition and wholesome ingredients in ACANA. . Your dog will love its delicious taste, and you’ll love that its nutritious ingredients help support 4 key health benefits, including Immune Health, Healthy Skin & Coat, Digestive Health and Healthy Weight.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 17,
                    Price = 19.99,
                },
                new Product
                {
                    Id = 18,
                    Name = "ACANA Classics, Beef and Barley Recipe",
                    BrandId = 10,
                    Description = "Help your dog feel so good inside, you’ll see it on the outside! Nurture your dog with the simple nutrition and wholesome ingredients in ACANA. . Your dog will love its delicious taste, and you’ll love that its nutritious ingredients help support 4 key health benefits, including Immune Health, Healthy Skin & Coat, Digestive Health and Healthy Weight.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 14,
                    Price = 19.99,
                },
                new Product
                {
                    Id = 19,
                    Name = "ACANA Classics, Salmon and Barley Recipe",
                    BrandId = 10,
                    Description = "Help your dog feel so good inside, you’ll see it on the outside! Nurture your dog with the simple nutrition and wholesome ingredients in ACANA. . Your dog will love its delicious taste, and you’ll love that its nutritious ingredients help support 4 key health benefits, including Immune Health, Healthy Skin & Coat, Digestive Health and Healthy Weight.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 14,
                    Price = 19.99,
                },
                new Product
                {
                    Id = 20,
                    Name = "Butcher's Favorites, Free-Run Poultry & Liver Recipe",
                    BrandId = 10,
                    Description = "Help your dog feel so good inside, you’ll see it on the outside! Nurture your dog with the simple nutrition and wholesome ingredients in ACANA. . Your dog will love its delicious taste, and you’ll love that its nutritious ingredients help support 4 key health benefits, including Immune Health, Healthy Skin & Coat, Digestive Health and Healthy Weight.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 14,
                    Price = 19.99,
                },
                new Product
                {
                    Id = 21,
                    Name = "Butcher's Favorites, Farm-Raised Beef & Liver Recipe",
                    BrandId = 10,
                    Description = "Help your dog feel so good inside, you’ll see it on the outside! Nurture your dog with the simple nutrition and wholesome ingredients in ACANA. . Your dog will love its delicious taste, and you’ll love that its nutritious ingredients help support 4 key health benefits, including Immune Health, Healthy Skin & Coat, Digestive Health and Healthy Weight.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 14,
                    Price = 19.99,
                },
                new Product
                {
                    Id = 22,
                    Name = "Butcher's Favorites, Wild-Caught Salmon Recipe",
                    BrandId = 10,
                    Description = "Help your dog feel so good inside, you’ll see it on the outside! Nurture your dog with the simple nutrition and wholesome ingredients in ACANA. . Your dog will love its delicious taste, and you’ll love that its nutritious ingredients help support 4 key health benefits, including Immune Health, Healthy Skin & Coat, Digestive Health and Healthy Weight.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 14,
                    Price = 21.99,
                }
                );
            modelBuilder.Entity<ProductImage>().HasData(
                new ProductImage
                {
                    Id = 12,
                    ImageId = 32,
                    ProductId = 12,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 13,
                    ImageId = 33,
                    ProductId = 13,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 14,
                    ImageId = 34,
                    ProductId = 14,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 15,
                    ImageId = 35,
                    ProductId = 15,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 16,
                    ImageId = 36,
                    ProductId = 16,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 17,
                    ImageId = 37,
                    ProductId = 17,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 18,
                    ImageId = 38,
                    ProductId = 18,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 19,
                    ImageId = 39,
                    ProductId = 19,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 20,
                    ImageId = 40,
                    ProductId = 20,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 21,
                    ImageId = 41,
                    ProductId = 21,
                    CreatedAt = _dateTime
                },
                new ProductImage
                {
                    Id = 22,
                    ImageId = 42,
                    ProductId = 22,
                    CreatedAt = _dateTime
                }

               );
        }
        private void SeedReviews(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ProductReview>().HasData(
                new ProductReview
                {
                    Id = 1,
                    CreatedAt = _dateTime,
                    ProductId = 1,
                    ReviewerId = 2,
                    Review = 5

                },
                new ProductReview
                {
                    Id = 2,
                    CreatedAt = _dateTime,
                    ProductId = 2,
                    ReviewerId = 3,
                    Review = 5

                },
                new ProductReview
                {
                    Id = 3,
                    CreatedAt = _dateTime,
                    ProductId = 2,
                    ReviewerId = 3,
                    Review = 4

                },
                new ProductReview
                {
                    Id = 4,
                    CreatedAt = _dateTime,
                    ProductId = 3,
                    ReviewerId = 2,
                    Review = 4

                },
                new ProductReview
                {
                    Id = 5,
                    CreatedAt = _dateTime,
                    ProductId = 5,
                    ReviewerId = 2,
                    Review = 3

                },
                new ProductReview
                {
                    Id = 6,
                    CreatedAt = _dateTime,
                    ProductId = 10,
                    ReviewerId = 2,
                    Review = 4
                },
                new ProductReview
                {
                    Id = 7,
                    CreatedAt = _dateTime,
                    ProductId = 20,
                    ReviewerId = 2,
                    Review = 5
                },
                new ProductReview
                {
                    Id = 8,
                    CreatedAt = _dateTime,
                    ProductId = 22,
                    ReviewerId = 3,
                    Review = 4
                },
                new ProductReview
                {
                    Id = 9,
                    CreatedAt = _dateTime,
                    ProductId = 14,
                    ReviewerId = 2,
                    Review = 4
                },
                new ProductReview
                {
                    Id = 10,
                    CreatedAt = _dateTime,
                    ProductId = 10,
                    ReviewerId = 3,
                    Review = 3
                },
                new ProductReview
                {
                    Id = 11,
                    CreatedAt = _dateTime,
                    ProductId = 23,
                    ReviewerId = 3,
                    Review = 4
                },
                new ProductReview
                {
                    Id = 12,
                    CreatedAt = _dateTime,
                    ProductId = 24,
                    ReviewerId = 3,
                    Review = 5
                },
                new ProductReview
                {
                    Id = 13,
                    CreatedAt = _dateTime,
                    ProductId = 24,
                    ReviewerId = 3,
                    Review = 4
                },
                new ProductReview
                {
                    Id = 14,
                    CreatedAt = _dateTime,
                    ProductId = 25,
                    ReviewerId = 3,
                    Review = 5
                },
                new ProductReview
                {
                    Id = 15,
                    CreatedAt = _dateTime,
                    ProductId = 29,
                    ReviewerId = 3,
                    Review = 3
                },
                new ProductReview
                {
                    Id = 16,
                    CreatedAt = _dateTime,
                    ProductId = 31,
                    ReviewerId = 3,
                    Review = 5
                },
                new ProductReview
                {
                    Id = 17,
                    CreatedAt = _dateTime,
                    ProductId = 32,
                    ReviewerId = 3,
                    Review = 4
                },
                new ProductReview
                {
                    Id = 18,
                    CreatedAt = _dateTime,
                    ProductId = 33,
                    ReviewerId = 3,
                    Review = 5
                },
                new ProductReview
                {
                    Id = 19,
                    CreatedAt = _dateTime,
                    ProductId = 37,
                    ReviewerId = 5,
                    Review = 5
                },
                new ProductReview
                {
                    Id = 20,
                    CreatedAt = _dateTime,
                    ProductId = 40,
                    ReviewerId = 5,
                    Review = 5
                },
                new ProductReview
                {
                    Id = 21,
                    CreatedAt = _dateTime,
                    ProductId = 42,
                    ReviewerId = 5,
                    Review = 5
                },
                new ProductReview
                {
                    Id = 22,
                    CreatedAt = _dateTime,
                    ProductId = 45,
                    ReviewerId = 5,
                    Review = 5
                },
                new ProductReview
                {
                    Id = 23,
                    CreatedAt = _dateTime,
                    ProductId = 48,
                    ReviewerId = 6,
                    Review = 4
                },
                new ProductReview
                {
                    Id = 24,
                    CreatedAt = _dateTime,
                    ProductId = 48,
                    ReviewerId = 4,
                    Review = 5
                },
                new ProductReview
                {
                    Id = 25,
                    CreatedAt = _dateTime,
                    ProductId = 55,
                    ReviewerId = 6,
                    Review = 4
                },
                new ProductReview
                {
                    Id = 26,
                    CreatedAt = _dateTime,
                    ProductId = 57,
                    ReviewerId = 3,
                    Review = 5
                }
                );

        }
        private void SeedProductsForFish(ModelBuilder modelBuilder, long upc)
        {
            modelBuilder.Entity<Image>().HasData(
                new Image
                {
                    Id = 56,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183528420?alt=media&token=e745de6d-808b-4378-94da-1bcb4e618ca5"
                },
                new Image
                {
                    Id = 57,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183584963?alt=media&token=496474ba-fc89-40dd-b05a-081370c2947a"
                },
                new Image
                {
                    Id = 58,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183651216?alt=media&token=76d4c8df-5bde-4490-9bf1-4b740c96dfa8"
                },
                new Image
                {
                    Id = 59,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183686317?alt=media&token=31f4391a-7c1a-44d6-a45e-4ff3048d40ea"
                },
                new Image
                {
                    Id = 60,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183715469?alt=media&token=4393223e-f1c6-4521-861e-84150496698d"
                },
                new Image
                {
                    Id = 61,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183746025?alt=media&token=6fd025f0-a18e-4d5c-8f18-2842446e9caf"
                },
                new Image
                {
                    Id = 62,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183793274?alt=media&token=8dcf22a2-b5ef-4152-8c4e-73a0333f8770"
                },
                new Image
                {
                    Id = 63,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183808286?alt=media&token=4bf2e052-7c52-413b-9b5f-918276c81ca0"
                },
                new Image
                {
                    Id = 64,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183835895?alt=media&token=7ddeb36c-6a6b-4b2b-8099-02362dfe98ff"
                },
                new Image
                {
                    Id = 65,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183874113?alt=media&token=8c48fc5d-a3fe-44f7-b182-6ec76624e231"
                },
                new Image
                {
                    Id = 66,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183926627?alt=media&token=50ea6235-4853-4516-9f2f-78ba8037d87f"
                },
                new Image
                {
                    Id = 67,
                    CreatedAt = _dateTime,
                    DownloadURL = "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183945529?alt=media&token=ab38060d-2012-4058-adbb-498f080d2cec"
                }
                );

            modelBuilder.Entity<Product>().HasData(
                new Product
                {
                    Id = 34,
                    Name = "TetraMin Tropical Flakes",
                    BrandId = 22,
                    Description = "Active Life Formula helps nutritionally support fish’s immune system for optimal health and long life. Based on long-term university studies, the proprietary formula joins high quality, complete nutrition with even more benefits.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 2.99,
                    ProductCategorySubcategoryId = 40,
                },
                new Product
                {
                    Id = 35,
                    Name = "TetraMin XL Tropical Flakes",
                    BrandId = 22,
                    Description = "Tetra brands original tropical fish diet, TetraMin XL Tropical Flakes is nutritionally balanced for optimum fish health. This formula is packed with patented ProCare that offers precise doses of select vitamins and nutrients to support immune system health, Biotin to help maintain metabolism, and Omega-3 fatty acids to provide energy and growth. TetraMin XL Tropical Flakes are scientifically developed to be easily digested and feature color enhancers that bring out the bright colors of your tropical fish. All the benefits of TetraMin, the world’s leading flake food, in a larger flake for bigger fish.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 5.99,
                    ProductCategorySubcategoryId = 40,
                },
                new Product
                {
                    Id = 36,
                    Name = "Community 3-in-1 Select-A-Food",
                    BrandId = 22,
                    Description = "Contains three different types of food for various fish diets:\r\nFlakes for top and mid-water feeders\r\nSlow-sinking granules for mid-water feeders\r\nMini wafers for bottom feeders",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 6.59,
                    ProductCategorySubcategoryId = 40,
                },
                new Product
                {
                    Id = 37,
                    Name = "TetraMin Plus Tropical Flakes",
                    BrandId = 22,
                    Description = "This premium food offers all of the advantages of the \"Clean and Clear Water Formula\" plus the added benefit of natural shrimp. The aroma and flavor of real shrimp are a natural attractant for aquarium fish.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 4.79,
                    ProductCategorySubcategoryId = 40,
                },
                new Product
                {
                    Id = 38,
                    Name = "TetraPro Tropical Crisps",
                    BrandId = 22,
                    Description = "TetraPro Tropical Crisps provide advanced nutrition for the discerning fish-keeper. This nutritionally balanced diet feeds cleaner than ordinary flakes, leaving behind less waste in the aquarium and in the can. Each crisp is made using an exclusive low-heat process which preserves essential vitamins for a healthier, more nutritious diet. TetraPro Crisps float longer to allow fish more time to eat and are precision crafted with Biotin to support fish immune system health.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 4.99,
                    ProductCategorySubcategoryId = 40,
                },
                new Product
                {
                    Id = 39,
                    Name = "TetraMin Crisps Select-A-Food",
                    BrandId = 22,
                    Description = "Features shrimp fish food treats and granules. Unique four-section canister provides highest quality nutrition and feeding fun. Contains two chambers of TetraMin® Tropical Crisps staple food, one chamber of BabyShrimp treats and one chamber of TetraMin® Granules. Easy-to-use dispenser top allows you to dial in the food that is desired. This versatile product provides healthy feeding and variety all in one package.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.29,
                    ProductCategorySubcategoryId = 40,
                },
                new Product
                {
                    Id = 40,
                    Name = "PRO Cory Wafers",
                    BrandId = 22,
                    Description = "Tetra PRO Cory wafers are a premium 2-in-1 food with shrimp and potato protein for easy digestibility and ideal protein for Omnivorous Grazers. This sinking food is ideal for bottom feeders and is protein rich for complete nutrition.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 4.80,
                    ProductCategorySubcategoryId = 40,
                },
                new Product
                {
                    Id = 41,
                    Name = "TetraPro Tropical Color Crisps",
                    BrandId = 22,
                    Description = "TetraPro Tropical Color Crisps provide advanced nutrition for the discerning fish-keeper. This nutritionally balanced diet floats longer and feeds cleaner than ordinary flakes; leaving less waste in the aquarium. Each crisp features a high content of natural color enhancers and special ingredient that ensure the full development of beautiful and rich coloration. TetraPro Tropical Color Crisps support fish immune health with Biotin and are created through a low-heat process that preserves more of the natural ingredients.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 8.99,
                    ProductCategorySubcategoryId = 40,
                },
                new Product
                {
                    Id = 42,
                    Name = "TetraBetta Plus Floating Mini Pellets",
                    BrandId = 22,
                    Description = "TetraBetta Plus Floating Mini Pellets is a nutritionally balanced, premium diet with powerful color enhancers. This high-protein formula includes precise amounts of selected vitamins and nutrients to help support fish immune system, and Omega 3 fatty acids for energy and growth. Small, carotene-rich, highly-palatable, floating pellets are ideally sized for Siamese Fighting Fish (Betta splendens).",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 2.99,
                    ProductCategorySubcategoryId = 40,
                },
                new Product
                {
                    Id = 43,
                    Name = "TetraFin Plus Goldfish Flakes",
                    BrandId = 22,
                    Description = "This premium food offers all of the advantages of \"Clean and Clear Water Formula\" plus the added benefit of added Spirulina algae flakes for optimal digestibility. Extra vegetable matter and specialized high protein fish meal makes this fish food most digestible food ever. Optimal digestibility means fewer uneaten particles and reduced fish waste for cleaner and clearer aquarium water.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 3.40,
                    ProductCategorySubcategoryId = 40,
                },
                new Product
                {
                    Id = 44,
                    Name = "JumboKrill Freeze-Dried Jumbo Shrimp",
                    BrandId = 22,
                    Description = "",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 5.10,
                    ProductCategorySubcategoryId = 44,
                },
                new Product
                {
                    Id = 45,
                    Name = "BloodWorms",
                    BrandId = 22,
                    Description = "BloodWorms is a premium quality, nutritious supplement to primary diets such as TetraMin Flakes. This tasty, freeze-dried treat provides extra energy and condition and is perfect for Bettas or other small to medium sized tropical and marine fish. BloodWorms are specially processed and tested to minimize the presence of undesirable organisms found in live bloodworms.",
                    UPC = (upc++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    Price = 2.50,
                    ProductCategorySubcategoryId = 44,
                }
                );

            modelBuilder.Entity<ProductImage>().HasData(
                new ProductImage { Id = 34, ImageId = 56, ProductId = 34, CreatedAt = _dateTime },
                new ProductImage { Id = 35, ImageId = 57, ProductId = 35, CreatedAt = _dateTime },
                new ProductImage { Id = 36, ImageId = 58, ProductId = 36, CreatedAt = _dateTime },
                new ProductImage { Id = 37, ImageId = 59, ProductId = 37, CreatedAt = _dateTime },
                new ProductImage { Id = 38, ImageId = 60, ProductId = 38, CreatedAt = _dateTime },
                new ProductImage { Id = 39, ImageId = 61, ProductId = 39, CreatedAt = _dateTime },
                new ProductImage { Id = 40, ImageId = 62, ProductId = 40, CreatedAt = _dateTime },
                new ProductImage { Id = 41, ImageId = 63, ProductId = 41, CreatedAt = _dateTime },
                new ProductImage { Id = 42, ImageId = 64, ProductId = 42, CreatedAt = _dateTime },
                new ProductImage { Id = 43, ImageId = 65, ProductId = 43, CreatedAt = _dateTime },
                new ProductImage { Id = 44, ImageId = 66, ProductId = 44, CreatedAt = _dateTime },
                new ProductImage { Id = 45, ImageId = 67, ProductId = 45, CreatedAt = _dateTime }

              );
        }
    }
}

