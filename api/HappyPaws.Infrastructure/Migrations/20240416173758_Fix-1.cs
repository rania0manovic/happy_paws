using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HappyPaws.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class Fix1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "PayId",
                table: "Orders",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PayId",
                table: "Orders");
        }
    }
}
