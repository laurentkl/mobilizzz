using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Mobilizzz_BackEnd.Migrations
{
    /// <inheritdoc />
    public partial class PendingUserRequests1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TeamMemberRequest_Users_PendingRequestsId",
                table: "TeamMemberRequest");

            migrationBuilder.DropPrimaryKey(
                name: "PK_TeamMemberRequest",
                table: "TeamMemberRequest");

            migrationBuilder.DropIndex(
                name: "IX_TeamMemberRequest_PendingTeamRequestsId",
                table: "TeamMemberRequest");

            migrationBuilder.RenameColumn(
                name: "PendingRequestsId",
                table: "TeamMemberRequest",
                newName: "PendingUserRequestsId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_TeamMemberRequest",
                table: "TeamMemberRequest",
                columns: new[] { "PendingTeamRequestsId", "PendingUserRequestsId" });

            migrationBuilder.CreateIndex(
                name: "IX_TeamMemberRequest_PendingUserRequestsId",
                table: "TeamMemberRequest",
                column: "PendingUserRequestsId");

            migrationBuilder.AddForeignKey(
                name: "FK_TeamMemberRequest_Users_PendingUserRequestsId",
                table: "TeamMemberRequest",
                column: "PendingUserRequestsId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TeamMemberRequest_Users_PendingUserRequestsId",
                table: "TeamMemberRequest");

            migrationBuilder.DropPrimaryKey(
                name: "PK_TeamMemberRequest",
                table: "TeamMemberRequest");

            migrationBuilder.DropIndex(
                name: "IX_TeamMemberRequest_PendingUserRequestsId",
                table: "TeamMemberRequest");

            migrationBuilder.RenameColumn(
                name: "PendingUserRequestsId",
                table: "TeamMemberRequest",
                newName: "PendingRequestsId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_TeamMemberRequest",
                table: "TeamMemberRequest",
                columns: new[] { "PendingRequestsId", "PendingTeamRequestsId" });

            migrationBuilder.CreateIndex(
                name: "IX_TeamMemberRequest_PendingTeamRequestsId",
                table: "TeamMemberRequest",
                column: "PendingTeamRequestsId");

            migrationBuilder.AddForeignKey(
                name: "FK_TeamMemberRequest_Users_PendingRequestsId",
                table: "TeamMemberRequest",
                column: "PendingRequestsId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
