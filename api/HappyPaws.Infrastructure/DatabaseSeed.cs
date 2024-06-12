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
        }

        private readonly DateTime _dateTime = DateTime.Now;

        private void SeedUsers(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().HasData(
                new User
                {
                    Id = 1,
                    FirstName = "Main",
                    LastName = "Admin",
                    Email = "admin",
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
                     Email = "user",
                     Role = Role.User,
                     Gender = Gender.Unknown,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     IsVerified = true,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
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
                     IsVerified = true,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                 },
                new User
                {
                    Id = 11,
                    FirstName = "Emma",
                    LastName = "Collins",
                    Email = "employee",
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
                    Email = "olivia.clark@happypaws.com",
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
                    Email = "sophia.king@happypaws.com",
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
            var currentAssembly = Assembly.GetExecutingAssembly();
            var currentDirectory = Path.GetDirectoryName(currentAssembly.Location);
            var solutionDirectory = Directory.GetParent(currentDirectory).Parent.Parent.Parent.FullName;
            var imagesPath = Path.Combine(solutionDirectory, "HappyPaws.Infrastructure", "SeedData", "Images", "ProductCategories");


            modelBuilder.Entity<Image>().HasData(
                new Image
                {
                    Id = 1,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "cat.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 2,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "dog.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 3,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "bird.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 4,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "small_animal.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 5,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "fish.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 6,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "other.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                });


            modelBuilder.Entity<ProductCategory>().HasData(
                new ProductCategory
                {
                    Id = 1,
                    Name = "Cat",
                    PhotoId = 1,
                    CreatedAt = _dateTime
                },
                new ProductCategory
                {
                    Id = 2,
                    Name = "Dog",
                    PhotoId = 2,
                    CreatedAt = _dateTime
                },
                new ProductCategory
                {
                    Id = 3,
                    Name = "Bird",
                    PhotoId = 3,
                    CreatedAt = _dateTime
                },
                new ProductCategory
                {
                    Id = 4,
                    Name = "Small animal",
                    PhotoId = 4,
                    CreatedAt = _dateTime
                },
                new ProductCategory
                {
                    Id = 5,
                    Name = "Fish",
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
            var currentAssembly = Assembly.GetExecutingAssembly();
            var currentDirectory = Path.GetDirectoryName(currentAssembly.Location);
            var solutionDirectory = Directory.GetParent(currentDirectory).Parent.Parent.Parent.FullName;
            var imagesPath = Path.Combine(solutionDirectory, "HappyPaws.Infrastructure", "SeedData", "Images", "ProductSubcategories");
            modelBuilder.Entity<Image>().HasData(

                new Image
                {
                    Id = 7,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "aquarium.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 8,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "bed.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 9,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "cage.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 10,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "carrier.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 11,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "collar.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 12,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "flakes.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 13,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "food.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 14,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "house.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 15,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "medicine.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 16,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "snack.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 17,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "toilet.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 18,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "toy.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 19,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "treat.png")),
                    ContentType = "image/png",
                    CreatedAt = _dateTime
                },
                new Image
                {
                    Id = 20,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "other.png")),
                    ContentType = "image/png",
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
                new ProductCategorySubcategory { Id = 29, ProductCategoryId = 4, ProductSubcategoryId = 3, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 30, ProductCategoryId = 4, ProductSubcategoryId = 4, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 31, ProductCategoryId = 4, ProductSubcategoryId = 7, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 32, ProductCategoryId = 4, ProductSubcategoryId = 8, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 33, ProductCategoryId = 4, ProductSubcategoryId = 9, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 34, ProductCategoryId = 4, ProductSubcategoryId = 10, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 35, ProductCategoryId = 4, ProductSubcategoryId = 11, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 36, ProductCategoryId = 4, ProductSubcategoryId = 12, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 37, ProductCategoryId = 4, ProductSubcategoryId = 13, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 38, ProductCategoryId = 4, ProductSubcategoryId = 14, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 39, ProductCategoryId = 5, ProductSubcategoryId = 1, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 40, ProductCategoryId = 5, ProductSubcategoryId = 6, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 41, ProductCategoryId = 5, ProductSubcategoryId = 7, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 42, ProductCategoryId = 5, ProductSubcategoryId = 9, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 43, ProductCategoryId = 5, ProductSubcategoryId = 11, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 44, ProductCategoryId = 5, ProductSubcategoryId = 13, CreatedAt = _dateTime },
                new ProductCategorySubcategory { Id = 45, ProductCategoryId = 5, ProductSubcategoryId = 14, CreatedAt = _dateTime },
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
                new Brand { Id = 21, Name = "Petcurean", CreatedAt = _dateTime }


                );

        }
        private void SeedProducts(ModelBuilder modelBuilder)
        {
            var currentAssembly = Assembly.GetExecutingAssembly();
            var currentDirectory = Path.GetDirectoryName(currentAssembly.Location);
            var solutionDirectory = Directory.GetParent(currentDirectory).Parent.Parent.Parent.FullName;
            var imagesPath = Path.Combine(solutionDirectory, "HappyPaws.Infrastructure", "SeedData", "Images", "Products");
            Random random = new();
            var upc1 = ((long)(random.NextDouble() * 9_000_000_000_000) + 1_000_000_000_000);
            var upc2 = ((long)(random.NextDouble() * 9_000_000_000_000) + 1_000_000_000_000);
            SeedProductsForCats(modelBuilder, imagesPath, random, upc1);
            SeedProductsForDogs(modelBuilder, imagesPath, random, upc2);

        }

        private void SeedProductsForCats(ModelBuilder modelBuilder, string imagesPath, Random random, long upc)
        {
            modelBuilder.Entity<Image>().HasData(
                new Image
                {
                    Id = 21,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "18461_BCC_Dry_food_7STERILIZED_URINARY_HEALTH 1.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 22,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "bcc_cans_kitten_tuna_3D-1.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 23,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "bcc-dry_food_kitten-1.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 24,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "bcc-insect-1.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 25,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "18461_BCC_Dry_food_ADULT.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 26,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "18461_BCC_Dry_food_SENSITIVE 1.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 27,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "18461_BCC_Dry_food_HAIRCARE 1.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 28,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "18461_BCC_Dry_food_STERILIZED_SENSITIVE 1.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 29,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "18461_BCC_Dry_food_STERILIZED_WEIGHT_CONTROL.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 30,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "18461_BCC_Dry_food_LARGE_CATS 1.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 31,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "savory-salmon.png")),
                    ContentType = "image/png"
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
                }

               );
        }
        private void SeedProductsForDogs(ModelBuilder modelBuilder, string imagesPath, Random random, long upc2)
        {
            modelBuilder.Entity<Image>().HasData(
                new Image
                {
                    Id = 32,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "insect-lamb.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 33,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "insect-rabbit.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 34,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "insect-salmon.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 35,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "insect-tuna.png")),
                    ContentType = "image/png"
                },
                new Image
                {
                    Id = 36,
                    Data = File.ReadAllBytes(Path.Combine(imagesPath, "insect-whey.png")),
                    ContentType = "image/png"
                }

                );


            modelBuilder.Entity<Product>().HasData(
                 new Product
                 {
                     Id = 12,
                     Name = "Brit Care Dog Crunchy Cracker Insect And Lamb",
                     BrandId = 1,
                     Description = "Functional Complementary Dog Food for Puppies.",
                     UPC = (upc2++).ToString(),
                     CreatedAt = _dateTime,
                     InStock = 50,
                     Price = 3.99,
                     ProductCategorySubcategoryId = 14,
                 },
                new Product
                {
                    Id = 13,
                    Name = "Brit Care Dog Crunchy Cracker Insect And Rabbit",
                    BrandId = 1,
                    Description = "Functional Complementary Dog Food for Puppies.",
                    UPC = (upc2++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 14,
                    Price = 3.99,
                },
                new Product
                {
                    Id = 14,
                    Name = "Brit Care Dog Crunchy Cracker Insect And Salmon",
                    BrandId = 1,
                    Description = "Functional Complementary Dog Food for Puppies.",
                    UPC = (upc2++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 14,
                    Price = 3.99,
                },
                new Product
                {
                    Id = 15,
                    Name = "Brit Care Dog Crunchy Cracker Insect And Tuna",
                    BrandId = 1,
                    Description = "Functional Complementary Dog Food for Puppies.",
                    UPC = (upc2++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 14,
                    Price = 3.99,
                },
                new Product
                {
                    Id = 16,
                    Name = "Brit Care Dog Crunchy Cracker Insect And Whey",
                    BrandId = 1,
                    Description = "Functional Complementary Dog Food for Puppies.",
                    UPC = (upc2++).ToString(),
                    CreatedAt = _dateTime,
                    InStock = 50,
                    ProductCategorySubcategoryId = 14,
                    Price = 3.99,
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
                }


               );
        }
    }
}
