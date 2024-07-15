using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Mobilizzz_BackEnd.Migrations
{
    /// <inheritdoc />
    public partial class AddVisibleAndPrivateOnTeam : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsPrivate",
                table: "Teams",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "IsVisible",
                table: "Teams",
                type: "boolean",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsPrivate",
                table: "Teams");

            migrationBuilder.DropColumn(
                name: "IsVisible",
                table: "Teams");
        }
    }
}
