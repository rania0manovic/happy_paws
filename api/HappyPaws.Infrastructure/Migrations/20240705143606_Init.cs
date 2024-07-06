using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace HappyPaws.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class Init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Brands",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Brands", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "EmailVerificationRequests",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Code = table.Column<int>(type: "int", nullable: false),
                    IsExpired = table.Column<bool>(type: "bit", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_EmailVerificationRequests", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Images",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DownloadURL = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Images", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "PetTypes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PetTypes", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "SystemConfigs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DonationsGoal = table.Column<double>(type: "float", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SystemConfigs", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "ProductCategories",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: false),
                    PhotoId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductCategories", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductCategories_Images_PhotoId",
                        column: x => x.PhotoId,
                        principalTable: "Images",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ProductSubcategories",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: false),
                    PhotoId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductSubcategories", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductSubcategories_Images_PhotoId",
                        column: x => x.PhotoId,
                        principalTable: "Images",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirstName = table.Column<string>(type: "nvarchar(32)", maxLength: 32, nullable: false),
                    LastName = table.Column<string>(type: "nvarchar(32)", maxLength: 32, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: false),
                    PasswordSalt = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: false),
                    Gender = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    Role = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    ProfilePhotoId = table.Column<int>(type: "int", nullable: true),
                    MyPawNumber = table.Column<string>(type: "nvarchar(16)", maxLength: 16, nullable: true),
                    ConnectionId = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    IsVerified = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    IsSubscribed = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    EmployeePosition = table.Column<int>(type: "int", nullable: true),
                    ImageId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Users_Images_ImageId",
                        column: x => x.ImageId,
                        principalTable: "Images",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Users_Images_ProfilePhotoId",
                        column: x => x.ProfilePhotoId,
                        principalTable: "Images",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "PetBreeds",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: false),
                    PetTypeId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PetBreeds", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PetBreeds_PetTypes_PetTypeId",
                        column: x => x.PetTypeId,
                        principalTable: "PetTypes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ProductCategorySubcategories",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProductCategoryId = table.Column<int>(type: "int", nullable: false),
                    ProductSubcategoryId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductCategorySubcategories", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductCategorySubcategories_ProductCategories_ProductCategoryId",
                        column: x => x.ProductCategoryId,
                        principalTable: "ProductCategories",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProductCategorySubcategories_ProductSubcategories_ProductSubcategoryId",
                        column: x => x.ProductSubcategoryId,
                        principalTable: "ProductSubcategories",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Donations",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Amount = table.Column<double>(type: "float", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Donations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Donations_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Notifications",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Message = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Seen = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Notifications", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Notifications_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserAddresses",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FullName = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    AddressOne = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    AddressTwo = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: true),
                    City = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    Country = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    PostalCode = table.Column<string>(type: "nvarchar(32)", maxLength: 32, nullable: false),
                    Phone = table.Column<string>(type: "nvarchar(32)", maxLength: 32, nullable: false),
                    Note = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: true),
                    IsInitialUserAddress = table.Column<bool>(type: "bit", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserAddresses", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserAddresses_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Pets",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(32)", maxLength: 32, nullable: false),
                    BirthDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Weight = table.Column<double>(type: "float", nullable: false),
                    Gender = table.Column<int>(type: "int", nullable: false),
                    OwnerId = table.Column<int>(type: "int", nullable: false),
                    PetBreedId = table.Column<int>(type: "int", nullable: false),
                    PhotoId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Pets", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Pets_Images_PhotoId",
                        column: x => x.PhotoId,
                        principalTable: "Images",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Pets_PetBreeds_PetBreedId",
                        column: x => x.PetBreedId,
                        principalTable: "PetBreeds",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Pets_Users_OwnerId",
                        column: x => x.OwnerId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Products",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    UPC = table.Column<string>(type: "nvarchar(13)", maxLength: 13, nullable: false),
                    Price = table.Column<double>(type: "float", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(1024)", maxLength: 1024, nullable: false),
                    InStock = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    IsActive = table.Column<bool>(type: "bit", nullable: true, defaultValue: true),
                    BrandId = table.Column<int>(type: "int", nullable: false),
                    ProductCategorySubcategoryId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Products", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Products_Brands_BrandId",
                        column: x => x.BrandId,
                        principalTable: "Brands",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Products_ProductCategorySubcategories_ProductCategorySubcategoryId",
                        column: x => x.ProductCategorySubcategoryId,
                        principalTable: "ProductCategorySubcategories",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Orders",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Status = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    PaymentMethod = table.Column<int>(type: "int", nullable: false),
                    PayId = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Shipping = table.Column<double>(type: "float", nullable: true),
                    Total = table.Column<double>(type: "float", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    ShippingAddressId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Orders", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Orders_UserAddresses_ShippingAddressId",
                        column: x => x.ShippingAddressId,
                        principalTable: "UserAddresses",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Orders_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Appointments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Reason = table.Column<string>(type: "nvarchar(512)", maxLength: 512, nullable: false),
                    Note = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    StartDateTime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    EndDateTime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsCancelled = table.Column<bool>(type: "bit", nullable: false),
                    PetId = table.Column<int>(type: "int", nullable: false),
                    EmployeeId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Appointments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Appointments_Pets_PetId",
                        column: x => x.PetId,
                        principalTable: "Pets",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Appointments_Users_EmployeeId",
                        column: x => x.EmployeeId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "PetAllergies",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    AllergySeverity = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    PetId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PetAllergies", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PetAllergies_Pets_PetId",
                        column: x => x.PetId,
                        principalTable: "Pets",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "PetMedications",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MedicationName = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    Dosage = table.Column<double>(type: "float", nullable: false),
                    DosageFrequency = table.Column<int>(type: "int", nullable: false),
                    Until = table.Column<DateTime>(type: "datetime2", nullable: false),
                    PetId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PetMedications", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PetMedications_Pets_PetId",
                        column: x => x.PetId,
                        principalTable: "Pets",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ProductImages",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProductId = table.Column<int>(type: "int", nullable: false),
                    ImageId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductImages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductImages_Images_ImageId",
                        column: x => x.ImageId,
                        principalTable: "Images",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ProductImages_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ProductReviews",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Review = table.Column<int>(type: "int", nullable: false),
                    Note = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ProductId = table.Column<int>(type: "int", nullable: false),
                    ReviewerId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductReviews", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductReviews_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ProductReviews_Users_ReviewerId",
                        column: x => x.ReviewerId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserCarts",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Quantity = table.Column<int>(type: "int", nullable: false, defaultValue: 1),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    ProductId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserCarts", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserCarts_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserCarts_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserFavourites",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    ProductId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserFavourites", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserFavourites_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserFavourites_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "OrderDetails",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Quantity = table.Column<int>(type: "int", nullable: false),
                    UnitPrice = table.Column<double>(type: "float", nullable: false),
                    OrderId = table.Column<int>(type: "int", nullable: false),
                    ProductId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrderDetails", x => x.Id);
                    table.ForeignKey(
                        name: "FK_OrderDetails_Orders_OrderId",
                        column: x => x.OrderId,
                        principalTable: "Orders",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_OrderDetails_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Brands",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "Name" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Brit" },
                    { 2, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Blue Buffalo" },
                    { 3, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Hill's Science Diet" },
                    { 4, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Purina" },
                    { 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Royal Canin" },
                    { 6, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Iams" },
                    { 7, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Merrick" },
                    { 8, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Taste of the Wild" },
                    { 9, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Wellness" },
                    { 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Acana" },
                    { 11, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Orijen" },
                    { 12, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Natural Balance" },
                    { 13, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Earthborn Holistic" },
                    { 14, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Diamond Naturals" },
                    { 15, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Zignature" },
                    { 16, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Fromm" },
                    { 17, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Canidae" },
                    { 18, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Nutro" },
                    { 19, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Instinct" },
                    { 20, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Science Diet" },
                    { 21, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Petcurean" },
                    { 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Tetra" },
                    { 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "GLEE" }
                });

            migrationBuilder.InsertData(
                table: "Images",
                columns: new[] { "Id", "CreatedAt", "DownloadURL", "ModifiedAt" },
                values: new object[,]
                {
                    { 1, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718571880926?alt=media&token=9452f92a-f6d4-4378-a6be-ad245c627a44", null },
                    { 2, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718571890300?alt=media&token=defe1580-5d1b-4606-8e7e-a527e25b5cc3", null },
                    { 3, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718571904326?alt=media&token=c214401f-1e66-4b09-b045-551a24e26a21", null },
                    { 4, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718571914808?alt=media&token=f218dd55-8525-4ec0-a7da-829b43979610", null },
                    { 5, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572194372?alt=media&token=72cfbf3c-269b-47b3-8341-a57e33a95e81", null },
                    { 6, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572203797?alt=media&token=aabc3cb5-2b8f-4f0c-85d7-04d721af205c", null },
                    { 7, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572229582?alt=media&token=e77740e8-eadf-4e89-b41e-36609caba757", null },
                    { 8, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572463285?alt=media&token=75702f07-f74d-4d2e-815d-5f48ab5491f4", null },
                    { 9, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572471391?alt=media&token=2eb29f60-7a0a-4a94-a4ea-e0b9203bd67e", null },
                    { 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572479874?alt=media&token=5555d732-76e7-47af-a75c-9ef60f0d603c", null },
                    { 11, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572488286?alt=media&token=42c52ab6-a70e-4c45-80f1-6a45bb27b419", null },
                    { 12, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572501204?alt=media&token=2f342a96-e8a7-48a3-8ccc-129e2c1affac", null },
                    { 13, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572509258?alt=media&token=23217630-22d3-4401-8f1c-1d347f084c56", null },
                    { 14, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572753515?alt=media&token=621d4b83-c4db-48ad-980f-0fa2706297a8", null },
                    { 15, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572519196?alt=media&token=ed519c4f-a764-4816-8ec4-450ae6b2b420", null },
                    { 16, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572531782?alt=media&token=86c37db9-6bd3-4cdf-9642-6af3f94204fa", null },
                    { 17, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572543532?alt=media&token=a0d40c26-ec1f-48fc-9d51-ad9ff92bc6be", null },
                    { 18, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572552307?alt=media&token=d3aa85c9-c704-44f4-b04e-c97587fe2151", null },
                    { 19, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572559793?alt=media&token=8fed84e5-c237-4830-b2d0-08a1a85d8def", null },
                    { 20, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718572567952?alt=media&token=d4f4c6cd-20fe-4b00-9621-66690039bd74", null },
                    { 21, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573577409?alt=media&token=4667380c-c2af-4f8a-9848-17eabef5be5e", null },
                    { 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573675523?alt=media&token=d4f313ec-7ba2-4a88-9995-4886fec87777", null },
                    { 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573705237?alt=media&token=beeff100-e5a4-4257-9f1b-151b79f01770", null },
                    { 24, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573727398?alt=media&token=ec11af2d-8146-4599-bf14-5001cb694faa", null },
                    { 25, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573748174?alt=media&token=8435ac5a-6414-44e4-a93b-6ca8530f62c8", null },
                    { 26, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573772707?alt=media&token=39b108f1-c9c0-484f-a3d2-a21e4ef73ee4", null },
                    { 27, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573788405?alt=media&token=b54020b0-1307-4677-ac69-2a811274681e", null },
                    { 28, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573816596?alt=media&token=2824be7a-7f93-4ec5-b3e7-d9ae0d09abcb", null },
                    { 29, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573834055?alt=media&token=a826219d-f27f-4ba2-b0c7-14633c4d27c0", null },
                    { 30, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573851364?alt=media&token=9f2dfeec-5f64-4cf9-ade1-da4ee17505a1", null },
                    { 31, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718573883211?alt=media&token=71dac2f2-ea73-469f-8870-715b2f4a6a7c", null },
                    { 32, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718574227806?alt=media&token=48f261b8-b34c-483c-86ad-35bb92267c3e", null },
                    { 33, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718574247502?alt=media&token=8f3ea19a-1300-4be1-bf8f-bb285525e23c", null },
                    { 34, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718574275926?alt=media&token=b548245c-e59e-47c5-b9ff-35a6b285266e", null },
                    { 35, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718574320317?alt=media&token=4f9122af-ac3d-46be-9bc6-1a629bd649c2", null },
                    { 36, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718574343800?alt=media&token=da6bc504-ac55-4ae9-9552-26c1525304f3", null },
                    { 37, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718575174572?alt=media&token=b054a3f5-2b70-48ed-922e-6e8efe356a0a", null },
                    { 38, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718575192827?alt=media&token=e0753162-98e5-455d-8132-32c46fbdec4c", null },
                    { 39, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718575207880?alt=media&token=367aaa4c-9b53-4796-9517-5b37f9bbab79", null },
                    { 40, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718575231513?alt=media&token=ef0460cd-a83f-4d5a-9bc1-cdf7f4b634e0", null },
                    { 41, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718575295800?alt=media&token=25cd953d-b3f4-449f-981c-d1e7f0199a74", null },
                    { 42, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718575323931?alt=media&token=3e12eed2-edb9-4521-a9b0-ea61e183dcd8", null },
                    { 43, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623454876?alt=media&token=b7220a38-2813-45dc-b482-3a9195c61d4e", null },
                    { 44, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623476263?alt=media&token=01bd0df0-293f-40b2-964f-f4b3c6d277d1", null },
                    { 45, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623498777?alt=media&token=2eb52d97-b653-4431-9a68-1e24d9d0cb49", null },
                    { 46, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623517796?alt=media&token=117bbcdb-0eff-4687-a4f3-1b7aab54a522", null },
                    { 47, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623548126?alt=media&token=f9938823-a187-4e57-9529-f2ac7afb7821", null },
                    { 48, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623567565?alt=media&token=a27c2f7c-3bbb-46e3-940d-cc9684e70fbc", null },
                    { 49, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623591139?alt=media&token=34f0e077-d64e-4d45-9d2c-a7fa15b6d27d", null },
                    { 50, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623617605?alt=media&token=cfaafb23-7aee-4173-83ce-292f0bf4a8a1", null },
                    { 51, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623645714?alt=media&token=5eda632e-77bd-47fb-bb22-e7dffac3a90a", null },
                    { 52, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623681116?alt=media&token=86687a37-61da-4172-aaec-8484f7724913", null },
                    { 53, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718623704058?alt=media&token=1f20a15b-05a2-4c0a-840f-53bd0781719e", null },
                    { 56, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183528420?alt=media&token=e745de6d-808b-4378-94da-1bcb4e618ca5", null },
                    { 57, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183584963?alt=media&token=496474ba-fc89-40dd-b05a-081370c2947a", null },
                    { 58, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183651216?alt=media&token=76d4c8df-5bde-4490-9bf1-4b740c96dfa8", null },
                    { 59, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183686317?alt=media&token=31f4391a-7c1a-44d6-a45e-4ff3048d40ea", null },
                    { 60, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183715469?alt=media&token=4393223e-f1c6-4521-861e-84150496698d", null },
                    { 61, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183746025?alt=media&token=6fd025f0-a18e-4d5c-8f18-2842446e9caf", null },
                    { 62, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183793274?alt=media&token=8dcf22a2-b5ef-4152-8c4e-73a0333f8770", null },
                    { 63, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183808286?alt=media&token=4bf2e052-7c52-413b-9b5f-918276c81ca0", null },
                    { 64, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183835895?alt=media&token=7ddeb36c-6a6b-4b2b-8099-02362dfe98ff", null },
                    { 65, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183874113?alt=media&token=8c48fc5d-a3fe-44f7-b182-6ec76624e231", null },
                    { 66, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183926627?alt=media&token=50ea6235-4853-4516-9f2f-78ba8037d87f", null },
                    { 67, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720183945529?alt=media&token=ab38060d-2012-4058-adbb-498f080d2cec", null },
                    { 68, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188175265?alt=media&token=1d28bf60-d5e1-46b5-bb5b-dd7ba84a7cd3", null },
                    { 69, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188226696?alt=media&token=ac3295bc-095a-4b24-ba21-60203c511991", null },
                    { 70, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188271275?alt=media&token=4ea322e7-a0d8-494f-a419-9168f1720cbf", null },
                    { 71, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188335655?alt=media&token=6d94b773-625c-41a0-80dc-bb75042f9a78", null },
                    { 72, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188349717?alt=media&token=c836de92-44e1-4b82-8048-c91fd9f7ff06", null },
                    { 73, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188375367?alt=media&token=aa8385fc-dfb7-4e33-8e05-bdbd7942eed8", null },
                    { 74, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188411179?alt=media&token=0e02d3fb-b2b0-4242-a440-aab3b07c9471", null },
                    { 75, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188475589?alt=media&token=cadfb3d8-4163-4a89-ba89-1ab2629b644a", null },
                    { 76, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188488399?alt=media&token=5b81af29-2404-4d00-a7f8-0fffafbdaa33", null },
                    { 77, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188509030?alt=media&token=dc0ec218-fe19-4228-969e-97fa07cf0052", null },
                    { 78, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188535155?alt=media&token=aa57abdf-9abc-4844-a17f-0d8659f4c49a", null },
                    { 79, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188586588?alt=media&token=7e18c575-283a-4d77-b12b-04dbf9b1e5d9", null },
                    { 80, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1720188600838?alt=media&token=b26949fa-ea16-4160-a819-06242ef076ac", null }
                });

            migrationBuilder.InsertData(
                table: "PetTypes",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "Name" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Cat" },
                    { 2, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Dog" },
                    { 3, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Rabbit" },
                    { 4, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Bird" },
                    { 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Fish" },
                    { 6, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Hamster" },
                    { 7, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Guinea Pig" },
                    { 8, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Snake" },
                    { 9, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Lizard" },
                    { 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Ferret" },
                    { 11, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Mouse" },
                    { 12, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Chinchilla" },
                    { 13, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Turtle" }
                });

            migrationBuilder.InsertData(
                table: "SystemConfigs",
                columns: new[] { "Id", "CreatedAt", "DonationsGoal", "IsDeleted", "ModifiedAt" },
                values: new object[] { 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 100.0, false, null });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "ConnectionId", "CreatedAt", "Email", "EmployeePosition", "FirstName", "Gender", "ImageId", "IsVerified", "LastName", "ModifiedAt", "MyPawNumber", "PasswordHash", "PasswordSalt", "ProfilePhotoId", "Role" },
                values: new object[] { 1, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "admin@happypaws.com", null, "Main", 1, null, true, "Admin", null, null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null, 2 });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "ConnectionId", "CreatedAt", "Email", "EmployeePosition", "FirstName", "ImageId", "IsVerified", "LastName", "ModifiedAt", "MyPawNumber", "PasswordHash", "PasswordSalt", "ProfilePhotoId" },
                values: new object[] { 2, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "user@happypaws.com", null, "Emily", null, true, "Johnson", null, "2224189566583186", "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "ConnectionId", "CreatedAt", "Email", "EmployeePosition", "FirstName", "Gender", "ImageId", "IsVerified", "LastName", "ModifiedAt", "MyPawNumber", "PasswordHash", "PasswordSalt", "ProfilePhotoId" },
                values: new object[,]
                {
                    { 3, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "sophia.williams@happypaws.com", null, "Sophia", 1, null, true, "Williams", null, "8904181155885348", "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null },
                    { 4, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "michael.martinez@happypaws.com", null, "Michael", 2, null, true, "Martinez", null, "8975663765604160", "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null },
                    { 5, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "olivia.taylor@happypaws.com", null, "Olivia", 1, null, true, "Taylor", null, "9495816737342002", "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null },
                    { 6, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "james.davis@happypaws.com", null, "James", 2, null, true, "Davis", null, "3885224776304963", "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null },
                    { 7, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "ava.miller@happypaws.com", null, "Ava", 1, null, true, "Miller", null, "3574862835168799", "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null },
                    { 8, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "william.anderson@happypaws.com", null, "William", 2, null, true, "Anderson", null, "3863165142311849", "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null },
                    { 9, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "isabella.wilson@happypaws.com", null, "Isabella", 1, null, true, "Wilson", null, "1375029585103447", "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null },
                    { 10, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "john.smith@happypaws.com", null, "John", 2, null, true, "Smith", null, "6514730626631608", "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null }
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "ConnectionId", "CreatedAt", "Email", "EmployeePosition", "FirstName", "Gender", "ImageId", "IsVerified", "LastName", "ModifiedAt", "MyPawNumber", "PasswordHash", "PasswordSalt", "ProfilePhotoId", "Role" },
                values: new object[,]
                {
                    { 11, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "vet@happypaws.com", 0, "Emma", 1, null, true, "Collins", null, null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null, 1 },
                    { 12, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "liam.roberts@happypaws.com", 1, "Liam", 2, null, true, "Roberts", null, null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null, 1 },
                    { 13, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "ava.stewart@happypaws.com", 2, "Ava", 1, null, true, "Stewart", null, null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null, 1 },
                    { 14, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "noah.harris@happypaws.com", 3, "Noah", 2, null, true, "Harris", null, null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null, 1 },
                    { 15, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "pharmacy@happypaws.com", 4, "Olivia", 1, null, true, "Clark", null, null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null, 1 },
                    { 16, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "william.young@happypaws.com", 5, "William", 2, null, true, "Young", null, null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null, 1 },
                    { 17, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "retail@happypaws.com", 6, "Sophia", 1, null, true, "King", null, null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null, 1 },
                    { 18, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "james.lee@happypaws.com", 5, "James", 2, null, true, "Lee", null, null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null, 1 },
                    { 19, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "isabella.moore@happypaws.com", 6, "Isabella", 1, null, true, "Moore", null, null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null, 1 },
                    { 20, null, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "mia.turner@happypaws.com", 2, "Mia", 1, null, true, "Turner", null, null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", null, 1 }
                });

            migrationBuilder.InsertData(
                table: "Orders",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "PayId", "PaymentMethod", "Shipping", "ShippingAddressId", "Status", "Total", "UserId" },
                values: new object[,]
                {
                    { 483641, new DateTime(2024, 6, 26, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 0, null, null, 5, 20.989999999999998, 2 },
                    { 483642, new DateTime(2024, 6, 28, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 0, null, null, 5, 23.940000000000001, 3 }
                });

            migrationBuilder.InsertData(
                table: "Orders",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "PayId", "PaymentMethod", "Shipping", "ShippingAddressId", "Total", "UserId" },
                values: new object[,]
                {
                    { 483643, new DateTime(2024, 7, 5, 10, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 0, null, null, 51.920000000000002, 2 },
                    { 483644, new DateTime(2024, 7, 5, 15, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 0, null, null, 39.979999999999997, 4 },
                    { 483645, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 0, null, null, 36.950000000000003, 2 }
                });

            migrationBuilder.InsertData(
                table: "PetBreeds",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "Name", "PetTypeId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Persian", 1 },
                    { 2, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Siamese", 1 },
                    { 3, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Maine Coon", 1 },
                    { 4, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "British Shorthair", 1 },
                    { 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Sphynx", 1 },
                    { 6, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Labrador Retriever", 2 },
                    { 7, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "German Shepherd", 2 },
                    { 8, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Golden Retriever", 2 },
                    { 9, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "French Bulldog", 2 },
                    { 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Beagle", 2 },
                    { 11, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Dutch", 3 },
                    { 12, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Holland Lop", 3 },
                    { 13, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Mini Rex", 3 },
                    { 14, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Netherland Dwarf", 3 },
                    { 15, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Flemish Giant", 3 },
                    { 16, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Budgerigar", 4 },
                    { 17, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Cockatiel", 4 },
                    { 18, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "African Grey Parrot", 4 },
                    { 19, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Canary", 4 },
                    { 20, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Macaw", 4 },
                    { 21, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Goldfish", 5 },
                    { 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Betta", 5 },
                    { 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Guppy", 5 },
                    { 24, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Angelfish", 5 },
                    { 25, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Koi", 5 },
                    { 26, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Syrian Hamster", 6 },
                    { 27, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Dwarf Hamster", 6 },
                    { 28, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Roborovski Hamster", 6 },
                    { 29, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Chinese Hamster", 6 },
                    { 30, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Campbell's Dwarf Hamster", 6 },
                    { 31, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "American Guinea Pig", 7 },
                    { 32, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Peruvian Guinea Pig", 7 },
                    { 33, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Abyssinian Guinea Pig", 7 },
                    { 34, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Teddy Guinea Pig", 7 },
                    { 35, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Silkie Guinea Pig", 7 },
                    { 36, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Ball Python", 8 },
                    { 37, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Corn Snake", 8 },
                    { 38, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Boa Constrictor", 8 },
                    { 39, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "King Snake", 8 },
                    { 40, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Milk Snake", 8 },
                    { 41, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Leopard Gecko", 9 },
                    { 42, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Bearded Dragon", 9 },
                    { 43, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Crested Gecko", 9 },
                    { 44, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Blue-Tongued Skink", 9 },
                    { 45, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Green Anole", 9 },
                    { 46, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Standard Ferret", 10 },
                    { 47, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Angora Ferret", 10 },
                    { 48, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Sable Ferret", 10 },
                    { 49, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Albino Ferret", 10 },
                    { 50, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Black-Footed Ferret", 10 },
                    { 51, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "House Mouse", 11 },
                    { 52, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Fancy Mouse", 11 },
                    { 53, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Lab Mouse", 11 },
                    { 54, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Pygmy Mouse", 11 },
                    { 55, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Harvest Mouse", 11 },
                    { 56, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Standard Chinchilla", 12 },
                    { 57, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Mutant Chinchilla", 12 },
                    { 58, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Wilson White Chinchilla", 12 },
                    { 59, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Black Velvet Chinchilla", 12 },
                    { 60, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Beige Chinchilla", 12 },
                    { 61, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Red-Eared Slider", 13 },
                    { 62, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Eastern Box Turtle", 13 },
                    { 63, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Painted Turtle", 13 },
                    { 64, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Russian Tortoise", 13 },
                    { 65, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Map Turtle", 13 }
                });

            migrationBuilder.InsertData(
                table: "ProductCategories",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "Name", "PhotoId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Cats", 1 },
                    { 2, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Dogs", 2 },
                    { 3, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Birds", 3 },
                    { 4, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Fish", 4 },
                    { 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Small animals", 5 },
                    { 6, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Other", 6 }
                });

            migrationBuilder.InsertData(
                table: "ProductSubcategories",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "Name", "PhotoId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Aquariums", 7 },
                    { 2, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Beds", 8 },
                    { 3, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Cages", 9 },
                    { 4, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Carriers", 10 },
                    { 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Collars", 11 },
                    { 6, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Fish Flakes", 12 },
                    { 7, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Food", 13 },
                    { 8, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Houses", 14 },
                    { 9, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Medicine", 15 },
                    { 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Snacks", 16 },
                    { 11, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Hygine", 17 },
                    { 12, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Toys", 18 },
                    { 13, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Treats", 19 },
                    { 14, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, "Other", 20 }
                });

            migrationBuilder.InsertData(
                table: "UserAddresses",
                columns: new[] { "Id", "AddressOne", "AddressTwo", "City", "Country", "CreatedAt", "FullName", "IsInitialUserAddress", "ModifiedAt", "Note", "Phone", "PostalCode", "UserId" },
                values: new object[] { 1, "Test address 1", null, "Mostar", "Bosnia and Herzegowina", new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Emily Johnson", true, null, null, "061 222 333", "88000", 2 });

            migrationBuilder.InsertData(
                table: "Pets",
                columns: new[] { "Id", "BirthDate", "CreatedAt", "Gender", "ModifiedAt", "Name", "OwnerId", "PetBreedId", "PhotoId", "Weight" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, null, "Tommy", 2, 1, null, 3.0 },
                    { 2, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, null, "Buddy", 2, 6, null, 2.0 },
                    { 3, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, null, "Bella", 3, 2, null, 5.0 },
                    { 4, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, null, "Snowball", 3, 13, null, 1.0 },
                    { 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, null, "Max", 3, 16, null, 0.20000000000000001 },
                    { 6, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, null, "Luna", 4, 3, null, 4.0 },
                    { 7, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, null, "Charlie", 4, 21, null, 0.10000000000000001 },
                    { 8, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, null, "Milo", 5, 8, null, 7.0 },
                    { 9, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, null, "Lucy", 6, 41, null, 0.050000000000000003 },
                    { 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, null, "Rocky", 6, 36, null, 1.5 },
                    { 11, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, null, "Oreo", 7, 51, null, 0.029999999999999999 },
                    { 12, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, null, "Mittens", 8, 62, null, 1.2 },
                    { 13, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, null, "Shadow", 8, 31, null, 0.40000000000000002 },
                    { 14, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, null, "Simba", 9, 10, null, 9.0 },
                    { 15, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, null, "Lily", 9, 41, null, 0.080000000000000002 },
                    { 16, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, null, "Max", 10, 9, null, 2.0 }
                });

            migrationBuilder.InsertData(
                table: "ProductCategorySubcategories",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "ProductCategoryId", "ProductSubcategoryId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 2 },
                    { 2, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 4 },
                    { 3, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 5 },
                    { 4, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 7 },
                    { 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 9 },
                    { 6, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 10 },
                    { 7, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 11 },
                    { 8, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 12 },
                    { 9, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 13 },
                    { 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 14 },
                    { 11, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 2, 2 },
                    { 12, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 2, 4 },
                    { 13, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 2, 5 },
                    { 14, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 2, 7 },
                    { 15, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 2, 8 },
                    { 16, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 2, 9 },
                    { 17, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 2, 10 },
                    { 18, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 2, 11 },
                    { 19, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 2, 12 },
                    { 20, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 2, 13 },
                    { 21, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 2, 14 },
                    { 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 3, 3 },
                    { 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 3, 7 },
                    { 24, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 3, 9 },
                    { 25, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 3, 10 },
                    { 26, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 3, 11 },
                    { 27, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 3, 13 },
                    { 28, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 3, 14 },
                    { 29, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 5, 3 },
                    { 30, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 5, 4 },
                    { 31, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 5, 7 },
                    { 32, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 5, 8 },
                    { 33, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 5, 9 },
                    { 34, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 5, 10 },
                    { 35, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 5, 11 },
                    { 36, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 5, 12 },
                    { 37, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 5, 13 },
                    { 38, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 5, 14 },
                    { 39, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 4, 1 },
                    { 40, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 4, 6 },
                    { 41, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 4, 7 },
                    { 42, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 4, 9 },
                    { 43, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 4, 11 },
                    { 44, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 4, 13 },
                    { 45, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 4, 14 },
                    { 46, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 6, 7 },
                    { 47, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 6, 14 }
                });

            migrationBuilder.InsertData(
                table: "Appointments",
                columns: new[] { "Id", "CreatedAt", "EmployeeId", "EndDateTime", "IsCancelled", "ModifiedAt", "Note", "PetId", "Reason", "StartDateTime" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 4, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, false, null, "Eats less and sleeps more", 1, "Behavioral changes", null },
                    { 2, new DateTime(2024, 7, 5, 6, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, false, null, null, 2, "Regular health check-up", null },
                    { 3, new DateTime(2024, 7, 5, 10, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, false, null, "Itching and hair loss", 5, "Skin issues", null },
                    { 4, new DateTime(2024, 7, 5, 12, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, false, null, null, 6, "Pregnancy", null },
                    { 5, new DateTime(2024, 7, 5, 14, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, false, null, null, 13, "Vaccination and check-up", null }
                });

            migrationBuilder.InsertData(
                table: "Products",
                columns: new[] { "Id", "BrandId", "CreatedAt", "Description", "InStock", "ModifiedAt", "Name", "Price", "ProductCategorySubcategoryId", "UPC" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.", 100, null, "Brit Care Cat Food Dry Sterilized Urinary Health", 10.99, 4, "7515066183858" },
                    { 2, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.", 100, null, "Brit Care Cat Food Dry Indoor", 10.0, 4, "7515066183859" },
                    { 3, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.", 100, null, "Brit Care Cat Dry Food Kitten", 12.0, 4, "7515066183860" },
                    { 4, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.", 100, null, "Brit Care Cat Dry Food Insects", 11.0, 4, "7515066183861" },
                    { 5, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.", 100, null, "Brit Care Cat Dry Food Adult", 15.0, 4, "7515066183862" },
                    { 6, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.", 100, null, "Brit Care Cat Dry Food Sensitive", 12.0, 4, "7515066183863" },
                    { 7, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.", 100, null, "Brit Care Cat Dry Haircare", 12.0, 4, "7515066183864" },
                    { 8, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.", 100, null, "Brit Care Cat Dry Food Sterilized Sensitive", 12.0, 4, "7515066183865" },
                    { 9, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.", 100, null, "Brit Care Cat Dry Sterilized Weight Control", 13.99, 4, "7515066183866" },
                    { 10, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Brit care dry foods are formulated to provide a balanced and nutritious diet for cats of all ages, breeds, and sizes. These premium-quality cat foods are crafted with high-quality ingredients to ensure optimal health, vitality, and wellbeing for your feline companions.", 100, null, "Brit Care Cat Dry Sterilized Large Cats", 13.99, 4, "7515066183867" },
                    { 11, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Fillets in Jelly with Savory Salmon enriched with Carrot & Rosemary. Complete superpremium wet food for Kittens.Delicate pouches for increasing the diversity of your cat’s diet, perfect for extra picky cats and cats with issues eating food. To make your cat’s belly feel even better, they also contain rosemary and carrots to support proper digestion.", 100, null, "Brit Care Cat Pouch Savory Salmon Jelly KITTEN", 1.99, 4, "7515066183868" },
                    { 12, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Functional Complementary Dog Food for Puppies.", 50, null, "Brit Care Dog Crunchy Cracker Insect And Lamb", 3.9900000000000002, 17, "7515066183908" },
                    { 13, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Functional Complementary Dog Food for Puppies.", 50, null, "Brit Care Dog Crunchy Cracker Insect And Rabbit", 3.9900000000000002, 17, "7515066183909" },
                    { 14, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Functional Complementary Dog Food for Puppies.", 50, null, "Brit Care Dog Crunchy Cracker Insect And Salmon", 3.9900000000000002, 17, "7515066183910" },
                    { 15, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Functional Complementary Dog Food for Puppies.", 50, null, "Brit Care Dog Crunchy Cracker Insect And Tuna", 3.9900000000000002, 17, "7515066183911" },
                    { 16, 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Functional Complementary Dog Food for Puppies.", 50, null, "Brit Care Dog Crunchy Cracker Insect And Whey", 3.9900000000000002, 17, "7515066183912" },
                    { 17, 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Help your dog feel so good inside, you’ll see it on the outside! Nurture your dog with the simple nutrition and wholesome ingredients in ACANA. . Your dog will love its delicious taste, and you’ll love that its nutritious ingredients help support 4 key health benefits, including Immune Health, Healthy Skin & Coat, Digestive Health and Healthy Weight.", 50, null, "ACANA Classics, Chicken and Barley Recipe", 19.989999999999998, 17, "7515066183913" },
                    { 18, 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Help your dog feel so good inside, you’ll see it on the outside! Nurture your dog with the simple nutrition and wholesome ingredients in ACANA. . Your dog will love its delicious taste, and you’ll love that its nutritious ingredients help support 4 key health benefits, including Immune Health, Healthy Skin & Coat, Digestive Health and Healthy Weight.", 50, null, "ACANA Classics, Beef and Barley Recipe", 19.989999999999998, 14, "7515066183914" },
                    { 19, 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Help your dog feel so good inside, you’ll see it on the outside! Nurture your dog with the simple nutrition and wholesome ingredients in ACANA. . Your dog will love its delicious taste, and you’ll love that its nutritious ingredients help support 4 key health benefits, including Immune Health, Healthy Skin & Coat, Digestive Health and Healthy Weight.", 50, null, "ACANA Classics, Salmon and Barley Recipe", 19.989999999999998, 14, "7515066183915" },
                    { 20, 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Help your dog feel so good inside, you’ll see it on the outside! Nurture your dog with the simple nutrition and wholesome ingredients in ACANA. . Your dog will love its delicious taste, and you’ll love that its nutritious ingredients help support 4 key health benefits, including Immune Health, Healthy Skin & Coat, Digestive Health and Healthy Weight.", 50, null, "Butcher's Favorites, Free-Run Poultry & Liver Recipe", 19.989999999999998, 14, "7515066183916" },
                    { 21, 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Help your dog feel so good inside, you’ll see it on the outside! Nurture your dog with the simple nutrition and wholesome ingredients in ACANA. . Your dog will love its delicious taste, and you’ll love that its nutritious ingredients help support 4 key health benefits, including Immune Health, Healthy Skin & Coat, Digestive Health and Healthy Weight.", 50, null, "Butcher's Favorites, Farm-Raised Beef & Liver Recipe", 19.989999999999998, 14, "7515066183917" },
                    { 22, 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Help your dog feel so good inside, you’ll see it on the outside! Nurture your dog with the simple nutrition and wholesome ingredients in ACANA. . Your dog will love its delicious taste, and you’ll love that its nutritious ingredients help support 4 key health benefits, including Immune Health, Healthy Skin & Coat, Digestive Health and Healthy Weight.", 50, null, "Butcher's Favorites, Wild-Caught Salmon Recipe", 21.989999999999998, 14, "7515066183918" },
                    { 23, 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Complete and balanced nutrition for cats.", 50, null, "Spayed & Neutered Thin Slices in Gravy Canned Cat Food", 3.4900000000000002, 4, "7515066183869" },
                    { 24, 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Complete and balanced nutrition for cats.", 50, null, "Indoor Adult Morsels in Gravy Canned Cat Food", 3.4900000000000002, 4, "7515066183870" },
                    { 25, 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Complete and balanced nutrition for cats.", 50, null, "Weight Care Thin Slices in Gravy Canned Cat Food", 3.4900000000000002, 4, "7515066183871" },
                    { 26, 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Complete and balanced nutrition for cats.", 50, null, "Adult Instinctive Loaf in Sauce Canned Cat Food", 3.4900000000000002, 4, "7515066183872" },
                    { 27, 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Complete and balanced nutrition for cats.", 50, null, "Mother & Babycat Ultra Soft Mousse in Sauce Canned Cat Food", 3.4900000000000002, 4, "7515066183873" },
                    { 28, 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Complete and balanced nutrition for cats.", 50, null, "Mother & Babycat Ultra Soft Mousse in Sauce Canned Cat Food", 3.4900000000000002, 4, "7515066183874" },
                    { 29, 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Complete and balanced nutrition for cats.", 50, null, "Appetite Control Care Thin Slices in Gravy Canned Cat Food", 3.4900000000000002, 4, "7515066183875" },
                    { 30, 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Complete and balanced nutrition for cats.", 50, null, "Kitten Thin Slices in Gravy", 3.4900000000000002, 4, "7515066183876" },
                    { 31, 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Complete and balanced nutrition for cats.", 50, null, "Kitten Loaf in Sauce Canned Cat Food", 3.4900000000000002, 4, "7515066183877" },
                    { 32, 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Complete and balanced nutrition for cats.", 50, null, "Persian Adult Loaf in Sauce canned cat food", 3.4900000000000002, 4, "7515066183878" },
                    { 33, 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Complete and balanced nutrition for cats.", 50, null, "Digest Sensitive Thin Slices in Gravy Canned Cat Food", 3.4900000000000002, 4, "7515066183879" },
                    { 34, 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Active Life Formula helps nutritionally support fish’s immune system for optimal health and long life. Based on long-term university studies, the proprietary formula joins high quality, complete nutrition with even more benefits.", 50, null, "TetraMin Tropical Flakes", 2.9900000000000002, 40, "7515066183958" },
                    { 35, 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Tetra brands original tropical fish diet, TetraMin XL Tropical Flakes is nutritionally balanced for optimum fish health. This formula is packed with patented ProCare that offers precise doses of select vitamins and nutrients to support immune system health, Biotin to help maintain metabolism, and Omega-3 fatty acids to provide energy and growth. TetraMin XL Tropical Flakes are scientifically developed to be easily digested and feature color enhancers that bring out the bright colors of your tropical fish. All the benefits of TetraMin, the world’s leading flake food, in a larger flake for bigger fish.", 50, null, "TetraMin XL Tropical Flakes", 5.9900000000000002, 40, "7515066183959" },
                    { 36, 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Contains three different types of food for various fish diets:\r\nFlakes for top and mid-water feeders\r\nSlow-sinking granules for mid-water feeders\r\nMini wafers for bottom feeders", 50, null, "Community 3-in-1 Select-A-Food", 6.5899999999999999, 40, "7515066183960" },
                    { 37, 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "This premium food offers all of the advantages of the \"Clean and Clear Water Formula\" plus the added benefit of natural shrimp. The aroma and flavor of real shrimp are a natural attractant for aquarium fish.", 50, null, "TetraMin Plus Tropical Flakes", 4.79, 40, "7515066183961" },
                    { 38, 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "TetraPro Tropical Crisps provide advanced nutrition for the discerning fish-keeper. This nutritionally balanced diet feeds cleaner than ordinary flakes, leaving behind less waste in the aquarium and in the can. Each crisp is made using an exclusive low-heat process which preserves essential vitamins for a healthier, more nutritious diet. TetraPro Crisps float longer to allow fish more time to eat and are precision crafted with Biotin to support fish immune system health.", 50, null, "TetraPro Tropical Crisps", 4.9900000000000002, 40, "7515066183962" },
                    { 39, 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Features shrimp fish food treats and granules. Unique four-section canister provides highest quality nutrition and feeding fun. Contains two chambers of TetraMin® Tropical Crisps staple food, one chamber of BabyShrimp treats and one chamber of TetraMin® Granules. Easy-to-use dispenser top allows you to dial in the food that is desired. This versatile product provides healthy feeding and variety all in one package.", 50, null, "TetraMin Crisps Select-A-Food", 3.29, 40, "7515066183963" },
                    { 40, 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Tetra PRO Cory wafers are a premium 2-in-1 food with shrimp and potato protein for easy digestibility and ideal protein for Omnivorous Grazers. This sinking food is ideal for bottom feeders and is protein rich for complete nutrition.", 50, null, "PRO Cory Wafers", 4.7999999999999998, 40, "7515066183964" },
                    { 41, 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "TetraPro Tropical Color Crisps provide advanced nutrition for the discerning fish-keeper. This nutritionally balanced diet floats longer and feeds cleaner than ordinary flakes; leaving less waste in the aquarium. Each crisp features a high content of natural color enhancers and special ingredient that ensure the full development of beautiful and rich coloration. TetraPro Tropical Color Crisps support fish immune health with Biotin and are created through a low-heat process that preserves more of the natural ingredients.", 50, null, "TetraPro Tropical Color Crisps", 8.9900000000000002, 40, "7515066183965" },
                    { 42, 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "TetraBetta Plus Floating Mini Pellets is a nutritionally balanced, premium diet with powerful color enhancers. This high-protein formula includes precise amounts of selected vitamins and nutrients to help support fish immune system, and Omega 3 fatty acids for energy and growth. Small, carotene-rich, highly-palatable, floating pellets are ideally sized for Siamese Fighting Fish (Betta splendens).", 50, null, "TetraBetta Plus Floating Mini Pellets", 2.9900000000000002, 40, "7515066183966" },
                    { 43, 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "This premium food offers all of the advantages of \"Clean and Clear Water Formula\" plus the added benefit of added Spirulina algae flakes for optimal digestibility. Extra vegetable matter and specialized high protein fish meal makes this fish food most digestible food ever. Optimal digestibility means fewer uneaten particles and reduced fish waste for cleaner and clearer aquarium water.", 50, null, "TetraFin Plus Goldfish Flakes", 3.3999999999999999, 40, "7515066183967" },
                    { 44, 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "", 50, null, "JumboKrill Freeze-Dried Jumbo Shrimp", 5.0999999999999996, 44, "7515066183968" },
                    { 45, 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "BloodWorms is a premium quality, nutritious supplement to primary diets such as TetraMin Flakes. This tasty, freeze-dried treat provides extra energy and condition and is perfect for Bettas or other small to medium sized tropical and marine fish. BloodWorms are specially processed and tested to minimize the presence of undesirable organisms found in live bloodworms.", 50, null, "BloodWorms", 2.5, 44, "7515066183969" },
                    { 46, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Comfortable beds for cats where they can relax and rest. With a very soft polyester.", 20, null, "Circular pouf bed", 19.989999999999998, 1, "7515066183880" },
                    { 47, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "", 20, null, "Flamingo Jean blue bed", 25.489999999999998, 1, "7515066183881" },
                    { 48, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "GLEE for pets beds “Insect Protection” keep your pets safe from insects & parasites since their revolutionary technology repels mosquitoes, mites, ticks, flies, fleas and other bugs that can carry dangerous illnesses such as Lyme disease and heartworm. The active ingredients permethrin-infused was tightly bonded to the fabric fibre used nanotechnology offers invisible, odorless, long-lasting, and effective protection for your dogs all year long.", 20, null, "Beds Insect Protection", 28.0, 1, "7515066183882" },
                    { 49, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "", 20, null, "Rectangular bed CATS", 23.989999999999998, 1, "7515066183883" },
                    { 50, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "", 20, null, "Rectangular bed FISHES", 23.989999999999998, 1, "7515066183884" },
                    { 51, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "", 20, null, "Rectangular bed JEAN blue", 22.0, 1, "7515066183885" },
                    { 52, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "", 20, null, "Rectangular bed terracotta", 24.489999999999998, 1, "7515066183886" },
                    { 53, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Comfortable sofas for cats with removable cushion cover.", 20, null, "Rectangular Sofas", 33.289999999999999, 1, "7515066183887" },
                    { 54, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Comfortable sofa for cats with removable cushion cover.", 20, null, "Rectangular sofa with pattern brown", 26.300000000000001, 1, "7515066183888" },
                    { 55, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Comfortable mattresses for and cats with removable cushion cover.", 20, null, "Waterproof rectangular beds", 24.989999999999998, 1, "7515066183889" },
                    { 56, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Comfortable beds “THE ORIGINALS” for cats where they can relax and rest.", 20, null, "Beds OYSTER", 29.989999999999998, 1, "7515066183890" },
                    { 57, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Comfortable beds “THE ORIGINALS” for cats where they can relax and rest.", 20, null, "Circular bed brown", 23.489999999999998, 1, "7515066183891" },
                    { 58, 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), "Comfortable beds “THE ORIGINALS” for cats where they can relax and rest.", 20, null, "Circular bed pink", 23.489999999999998, 1, "7515066183892" }
                });

            migrationBuilder.InsertData(
                table: "OrderDetails",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "OrderId", "ProductId", "Quantity", "UnitPrice" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 483641, 1, 1, 10.99 },
                    { 2, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 483641, 2, 1, 10.0 },
                    { 3, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 483642, 14, 2, 3.9900000000000002 },
                    { 4, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 483642, 15, 4, 3.9900000000000002 },
                    { 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 483643, 26, 4, 3.4900000000000002 },
                    { 6, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 483643, 31, 4, 3.4900000000000002 },
                    { 7, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 483643, 3, 2, 12.0 },
                    { 8, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 483644, 21, 2, 19.989999999999998 },
                    { 9, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 483645, 5, 1, 15.0 },
                    { 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 483645, 10, 1, 13.99 },
                    { 11, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 483645, 11, 4, 1.99 }
                });

            migrationBuilder.InsertData(
                table: "ProductImages",
                columns: new[] { "Id", "CreatedAt", "ImageId", "ModifiedAt", "ProductId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 21, null, 1 },
                    { 2, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 22, null, 2 },
                    { 3, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 23, null, 3 },
                    { 4, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 24, null, 4 },
                    { 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 25, null, 5 },
                    { 6, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 26, null, 6 },
                    { 7, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 27, null, 7 },
                    { 8, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 28, null, 8 },
                    { 9, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 29, null, 9 },
                    { 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 30, null, 10 },
                    { 11, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 31, null, 11 },
                    { 12, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 32, null, 12 },
                    { 13, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 33, null, 13 },
                    { 14, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 34, null, 14 },
                    { 15, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 35, null, 15 },
                    { 16, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 36, null, 16 },
                    { 17, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 37, null, 17 },
                    { 18, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 38, null, 18 },
                    { 19, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 39, null, 19 },
                    { 20, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 40, null, 20 },
                    { 21, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 41, null, 21 },
                    { 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 42, null, 22 },
                    { 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 43, null, 23 },
                    { 24, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 44, null, 24 },
                    { 25, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 45, null, 25 },
                    { 26, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 46, null, 26 },
                    { 27, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 47, null, 27 },
                    { 28, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 48, null, 28 },
                    { 29, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 49, null, 29 },
                    { 30, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 50, null, 30 },
                    { 31, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 51, null, 31 },
                    { 32, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 52, null, 32 },
                    { 33, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 53, null, 33 },
                    { 34, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 56, null, 34 },
                    { 35, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 57, null, 35 },
                    { 36, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 58, null, 36 },
                    { 37, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 59, null, 37 },
                    { 38, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 60, null, 38 },
                    { 39, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 61, null, 39 },
                    { 40, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 62, null, 40 },
                    { 41, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 63, null, 41 },
                    { 42, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 64, null, 42 },
                    { 43, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 65, null, 43 },
                    { 44, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 66, null, 44 },
                    { 45, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 67, null, 45 },
                    { 46, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 68, null, 46 },
                    { 47, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 69, null, 47 },
                    { 48, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 70, null, 48 },
                    { 49, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 71, null, 49 },
                    { 50, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 72, null, 50 },
                    { 51, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 73, null, 51 },
                    { 52, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 74, null, 52 },
                    { 53, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 75, null, 53 },
                    { 54, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 76, null, 54 },
                    { 55, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 77, null, 55 },
                    { 56, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 78, null, 56 },
                    { 57, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 79, null, 57 },
                    { 58, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), 80, null, 58 }
                });

            migrationBuilder.InsertData(
                table: "ProductReviews",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "Note", "ProductId", "Review", "ReviewerId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 1, 5, 2 },
                    { 2, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 2, 5, 3 },
                    { 3, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 2, 4, 3 },
                    { 4, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 3, 4, 2 },
                    { 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 5, 3, 2 },
                    { 6, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 10, 4, 2 },
                    { 7, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 20, 5, 2 },
                    { 8, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 22, 4, 3 },
                    { 9, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 14, 4, 2 },
                    { 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 10, 3, 3 },
                    { 11, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 23, 4, 3 },
                    { 12, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 24, 5, 3 },
                    { 13, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 24, 4, 3 },
                    { 14, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 25, 5, 3 },
                    { 15, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 29, 3, 3 },
                    { 16, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 31, 5, 3 },
                    { 17, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 32, 4, 3 },
                    { 18, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 33, 5, 3 },
                    { 19, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 37, 5, 5 },
                    { 20, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 40, 5, 5 },
                    { 21, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 42, 5, 5 },
                    { 22, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 45, 5, 5 },
                    { 23, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 48, 4, 6 },
                    { 24, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 48, 5, 4 },
                    { 25, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 55, 4, 6 },
                    { 26, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, null, 57, 5, 3 }
                });

            migrationBuilder.InsertData(
                table: "UserFavourites",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "ProductId", "UserId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 2 },
                    { 2, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 3 },
                    { 3, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 1, 4 },
                    { 4, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 5, 2 },
                    { 5, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 5, 3 },
                    { 6, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 11, 3 },
                    { 7, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 30, 3 },
                    { 8, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 33, 4 },
                    { 9, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 9, 4 },
                    { 10, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 2, 2 },
                    { 11, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 48, 2 },
                    { 12, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 48, 3 },
                    { 13, new DateTime(2024, 7, 5, 16, 36, 4, 476, DateTimeKind.Local).AddTicks(8186), null, 48, 4 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Appointments_EmployeeId",
                table: "Appointments",
                column: "EmployeeId");

            migrationBuilder.CreateIndex(
                name: "IX_Appointments_PetId",
                table: "Appointments",
                column: "PetId");

            migrationBuilder.CreateIndex(
                name: "IX_Donations_UserId",
                table: "Donations",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Notifications_UserId",
                table: "Notifications",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_OrderDetails_OrderId",
                table: "OrderDetails",
                column: "OrderId");

            migrationBuilder.CreateIndex(
                name: "IX_OrderDetails_ProductId",
                table: "OrderDetails",
                column: "ProductId");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_ShippingAddressId",
                table: "Orders",
                column: "ShippingAddressId");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_UserId",
                table: "Orders",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_PetAllergies_PetId",
                table: "PetAllergies",
                column: "PetId");

            migrationBuilder.CreateIndex(
                name: "IX_PetBreeds_PetTypeId",
                table: "PetBreeds",
                column: "PetTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_PetMedications_PetId",
                table: "PetMedications",
                column: "PetId");

            migrationBuilder.CreateIndex(
                name: "IX_Pets_OwnerId",
                table: "Pets",
                column: "OwnerId");

            migrationBuilder.CreateIndex(
                name: "IX_Pets_PetBreedId",
                table: "Pets",
                column: "PetBreedId");

            migrationBuilder.CreateIndex(
                name: "IX_Pets_PhotoId",
                table: "Pets",
                column: "PhotoId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductCategories_PhotoId",
                table: "ProductCategories",
                column: "PhotoId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductCategorySubcategories_ProductCategoryId",
                table: "ProductCategorySubcategories",
                column: "ProductCategoryId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductCategorySubcategories_ProductSubcategoryId",
                table: "ProductCategorySubcategories",
                column: "ProductSubcategoryId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductImages_ImageId",
                table: "ProductImages",
                column: "ImageId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductImages_ProductId",
                table: "ProductImages",
                column: "ProductId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductReviews_ProductId",
                table: "ProductReviews",
                column: "ProductId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductReviews_ReviewerId",
                table: "ProductReviews",
                column: "ReviewerId");

            migrationBuilder.CreateIndex(
                name: "IX_Products_BrandId",
                table: "Products",
                column: "BrandId");

            migrationBuilder.CreateIndex(
                name: "IX_Products_ProductCategorySubcategoryId",
                table: "Products",
                column: "ProductCategorySubcategoryId");

            migrationBuilder.CreateIndex(
                name: "IX_Products_UPC",
                table: "Products",
                column: "UPC",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_ProductSubcategories_PhotoId",
                table: "ProductSubcategories",
                column: "PhotoId");

            migrationBuilder.CreateIndex(
                name: "IX_UserAddresses_UserId",
                table: "UserAddresses",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_UserCarts_ProductId",
                table: "UserCarts",
                column: "ProductId");

            migrationBuilder.CreateIndex(
                name: "IX_UserCarts_UserId",
                table: "UserCarts",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_UserFavourites_ProductId",
                table: "UserFavourites",
                column: "ProductId");

            migrationBuilder.CreateIndex(
                name: "IX_UserFavourites_UserId",
                table: "UserFavourites",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_ImageId",
                table: "Users",
                column: "ImageId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_ProfilePhotoId",
                table: "Users",
                column: "ProfilePhotoId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Appointments");

            migrationBuilder.DropTable(
                name: "Donations");

            migrationBuilder.DropTable(
                name: "EmailVerificationRequests");

            migrationBuilder.DropTable(
                name: "Notifications");

            migrationBuilder.DropTable(
                name: "OrderDetails");

            migrationBuilder.DropTable(
                name: "PetAllergies");

            migrationBuilder.DropTable(
                name: "PetMedications");

            migrationBuilder.DropTable(
                name: "ProductImages");

            migrationBuilder.DropTable(
                name: "ProductReviews");

            migrationBuilder.DropTable(
                name: "SystemConfigs");

            migrationBuilder.DropTable(
                name: "UserCarts");

            migrationBuilder.DropTable(
                name: "UserFavourites");

            migrationBuilder.DropTable(
                name: "Orders");

            migrationBuilder.DropTable(
                name: "Pets");

            migrationBuilder.DropTable(
                name: "Products");

            migrationBuilder.DropTable(
                name: "UserAddresses");

            migrationBuilder.DropTable(
                name: "PetBreeds");

            migrationBuilder.DropTable(
                name: "Brands");

            migrationBuilder.DropTable(
                name: "ProductCategorySubcategories");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "PetTypes");

            migrationBuilder.DropTable(
                name: "ProductCategories");

            migrationBuilder.DropTable(
                name: "ProductSubcategories");

            migrationBuilder.DropTable(
                name: "Images");
        }
    }
}
