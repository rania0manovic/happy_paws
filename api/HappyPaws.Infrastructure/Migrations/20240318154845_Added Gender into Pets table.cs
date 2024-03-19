using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HappyPaws.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddedGenderintoPetstable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Gender",
                table: "Pets",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Gender",
                table: "Pets");
        }
    }
}
