using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HappyPaws.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class addedphototoProductCategories_fix : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProductCategories_ImageDto_PhotoId",
                table: "ProductCategories");

            migrationBuilder.DropTable(
                name: "ImageDto");

            migrationBuilder.AddForeignKey(
                name: "FK_ProductCategories_Images_PhotoId",
                table: "ProductCategories",
                column: "PhotoId",
                principalTable: "Images",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProductCategories_Images_PhotoId",
                table: "ProductCategories");

            migrationBuilder.CreateTable(
                name: "ImageDto",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ContentType = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Data = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ImageDto", x => x.Id);
                });

            migrationBuilder.AddForeignKey(
                name: "FK_ProductCategories_ImageDto_PhotoId",
                table: "ProductCategories",
                column: "PhotoId",
                principalTable: "ImageDto",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);
        }
    }
}
