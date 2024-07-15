using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Mobilizzz_BackEnd.Migrations
{
    /// <inheritdoc />
    public partial class AddAdminOnTeams : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AdminIds",
                table: "Teams");

            migrationBuilder.CreateTable(
                name: "AdminTeam",
                columns: table => new
                {
                    AdminsId = table.Column<int>(type: "integer", nullable: false),
                    TeamsOwnerShipId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AdminTeam", x => new { x.AdminsId, x.TeamsOwnerShipId });
                    table.ForeignKey(
                        name: "FK_AdminTeam_Teams_TeamsOwnerShipId",
                        column: x => x.TeamsOwnerShipId,
                        principalTable: "Teams",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AdminTeam_Users_AdminsId",
                        column: x => x.AdminsId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AdminTeam_TeamsOwnerShipId",
                table: "AdminTeam",
                column: "TeamsOwnerShipId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AdminTeam");

            migrationBuilder.AddColumn<List<int>>(
                name: "AdminIds",
                table: "Teams",
                type: "integer[]",
                nullable: true);
        }
    }
}
