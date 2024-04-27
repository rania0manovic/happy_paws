using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HappyPaws.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class Fix_4 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "UPC",
                table: "Products",
                type: "nvarchar(12)",
                maxLength: 12,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(12)",
                oldMaxLength: 12,
                oldDefaultValue: "000000000000");

            migrationBuilder.CreateIndex(
                name: "IX_Products_UPC",
                table: "Products",
                column: "UPC",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Products_UPC",
                table: "Products");

            migrationBuilder.AlterColumn<string>(
                name: "UPC",
                table: "Products",
                type: "nvarchar(12)",
                maxLength: 12,
                nullable: false,
                defaultValue: "000000000000",
                oldClrType: typeof(string),
                oldType: "nvarchar(12)",
                oldMaxLength: 12);
        }
    }
}
