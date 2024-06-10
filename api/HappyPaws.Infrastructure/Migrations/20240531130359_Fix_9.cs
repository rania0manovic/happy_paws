using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HappyPaws.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class Fix_9 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Appointments_Users_EmployeeId",
                table: "Appointments");

            migrationBuilder.AddForeignKey(
                name: "FK_Appointments_Users_EmployeeId",
                table: "Appointments",
                column: "EmployeeId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Appointments_Users_EmployeeId",
                table: "Appointments");

            migrationBuilder.AddForeignKey(
                name: "FK_Appointments_Users_EmployeeId",
                table: "Appointments",
                column: "EmployeeId",
                principalTable: "Users",
                principalColumn: "Id");
        }
    }
}
