using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HappyPaws.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class Fix_3 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ReviewerId",
                table: "ProductReviews",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_ProductReviews_ReviewerId",
                table: "ProductReviews",
                column: "ReviewerId");

            migrationBuilder.AddForeignKey(
                name: "FK_ProductReviews_Users_ReviewerId",
                table: "ProductReviews",
                column: "ReviewerId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProductReviews_Users_ReviewerId",
                table: "ProductReviews");

            migrationBuilder.DropIndex(
                name: "IX_ProductReviews_ReviewerId",
                table: "ProductReviews");

            migrationBuilder.DropColumn(
                name: "ReviewerId",
                table: "ProductReviews");
        }
    }
}
