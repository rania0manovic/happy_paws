using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HappyPaws.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class addedphototoProductCategories : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "PhotoId",
                table: "ProductCategories",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "ImageDto",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Data = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    ContentType = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ImageDto", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProductCategories_PhotoId",
                table: "ProductCategories",
                column: "PhotoId");

            migrationBuilder.AddForeignKey(
                name: "FK_ProductCategories_ImageDto_PhotoId",
                table: "ProductCategories",
                column: "PhotoId",
                principalTable: "ImageDto",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProductCategories_ImageDto_PhotoId",
                table: "ProductCategories");

            migrationBuilder.DropTable(
                name: "ImageDto");

            migrationBuilder.DropIndex(
                name: "IX_ProductCategories_PhotoId",
                table: "ProductCategories");

            migrationBuilder.DropColumn(
                name: "PhotoId",
                table: "ProductCategories");
        }
    }
}
