using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Mobilizzz_BackEnd.Migrations
{
    /// <inheritdoc />
    public partial class PendingUserRequests : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "TeamMemberRequest",
                columns: table => new
                {
                    PendingRequestsId = table.Column<int>(type: "integer", nullable: false),
                    PendingTeamRequestsId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TeamMemberRequest", x => new { x.PendingRequestsId, x.PendingTeamRequestsId });
                    table.ForeignKey(
                        name: "FK_TeamMemberRequest_Teams_PendingTeamRequestsId",
                        column: x => x.PendingTeamRequestsId,
                        principalTable: "Teams",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TeamMemberRequest_Users_PendingRequestsId",
                        column: x => x.PendingRequestsId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_TeamMemberRequest_PendingTeamRequestsId",
                table: "TeamMemberRequest",
                column: "PendingTeamRequestsId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TeamMemberRequest");
        }
    }
}
