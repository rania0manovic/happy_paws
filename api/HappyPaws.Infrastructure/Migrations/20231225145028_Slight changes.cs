using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HappyPaws.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class Slightchanges : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_ProductSubcategories_ProductSubcategoryId",
                table: "Products");

            migrationBuilder.DropForeignKey(
                name: "FK_ProductSubcategories_ProductCategories_ProductCategoryId",
                table: "ProductSubcategories");

            migrationBuilder.RenameColumn(
                name: "ProductCategoryId",
                table: "ProductSubcategories",
                newName: "PhotoId");

            migrationBuilder.RenameIndex(
                name: "IX_ProductSubcategories_ProductCategoryId",
                table: "ProductSubcategories",
                newName: "IX_ProductSubcategories_PhotoId");

            migrationBuilder.RenameColumn(
                name: "ProductSubcategoryId",
                table: "Products",
                newName: "ProductCategorySubcategoryId");

            migrationBuilder.RenameIndex(
                name: "IX_Products_ProductSubcategoryId",
                table: "Products",
                newName: "IX_Products_ProductCategorySubcategoryId");

            migrationBuilder.CreateTable(
                name: "ProductCategorySubcategories",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProductCategoryId = table.Column<int>(type: "int", nullable: false),
                    ProductSubcategoryId = table.Column<int>(type: "int", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductCategorySubcategories", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductCategorySubcategories_ProductCategories_ProductCategoryId",
                        column: x => x.ProductCategoryId,
                        principalTable: "ProductCategories",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "FK_ProductCategorySubcategories_ProductSubcategories_ProductSubcategoryId",
                        column: x => x.ProductSubcategoryId,
                        principalTable: "ProductSubcategories",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProductCategorySubcategories_ProductCategoryId",
                table: "ProductCategorySubcategories",
                column: "ProductCategoryId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductCategorySubcategories_ProductSubcategoryId",
                table: "ProductCategorySubcategories",
                column: "ProductSubcategoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_ProductCategorySubcategories_ProductCategorySubcategoryId",
                table: "Products",
                column: "ProductCategorySubcategoryId",
                principalTable: "ProductCategorySubcategories",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);

            migrationBuilder.AddForeignKey(
                name: "FK_ProductSubcategories_Images_PhotoId",
                table: "ProductSubcategories",
                column: "PhotoId",
                principalTable: "Images",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_ProductCategorySubcategories_ProductCategorySubcategoryId",
                table: "Products");

            migrationBuilder.DropForeignKey(
                name: "FK_ProductSubcategories_Images_PhotoId",
                table: "ProductSubcategories");

            migrationBuilder.DropTable(
                name: "ProductCategorySubcategories");

            migrationBuilder.RenameColumn(
                name: "PhotoId",
                table: "ProductSubcategories",
                newName: "ProductCategoryId");

            migrationBuilder.RenameIndex(
                name: "IX_ProductSubcategories_PhotoId",
                table: "ProductSubcategories",
                newName: "IX_ProductSubcategories_ProductCategoryId");

            migrationBuilder.RenameColumn(
                name: "ProductCategorySubcategoryId",
                table: "Products",
                newName: "ProductSubcategoryId");

            migrationBuilder.RenameIndex(
                name: "IX_Products_ProductCategorySubcategoryId",
                table: "Products",
                newName: "IX_Products_ProductSubcategoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_ProductSubcategories_ProductSubcategoryId",
                table: "Products",
                column: "ProductSubcategoryId",
                principalTable: "ProductSubcategories",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);

            migrationBuilder.AddForeignKey(
                name: "FK_ProductSubcategories_ProductCategories_ProductCategoryId",
                table: "ProductSubcategories",
                column: "ProductCategoryId",
                principalTable: "ProductCategories",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);
        }
    }
}
