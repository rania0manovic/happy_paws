using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HappyPaws.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class PetAllergystructurechanged : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PetAllergies_Allergies_AllergyId",
                table: "PetAllergies");

            migrationBuilder.DropTable(
                name: "Allergies");

            migrationBuilder.DropIndex(
                name: "IX_PetAllergies_AllergyId",
                table: "PetAllergies");

            migrationBuilder.DropColumn(
                name: "AllergyId",
                table: "PetAllergies");

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "PetAllergies",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Name",
                table: "PetAllergies");

            migrationBuilder.AddColumn<int>(
                name: "AllergyId",
                table: "PetAllergies",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "Allergies",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Name = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Allergies", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_PetAllergies_AllergyId",
                table: "PetAllergies",
                column: "AllergyId");

            migrationBuilder.AddForeignKey(
                name: "FK_PetAllergies_Allergies_AllergyId",
                table: "PetAllergies",
                column: "AllergyId",
                principalTable: "Allergies",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
