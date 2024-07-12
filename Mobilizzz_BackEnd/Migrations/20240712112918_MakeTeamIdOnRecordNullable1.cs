using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Mobilizzz_BackEnd.Migrations
{
    /// <inheritdoc />
    public partial class MakeTeamIdOnRecordNullable1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Records_Teams_TeamId",
                table: "Records");

            migrationBuilder.AlterColumn<int>(
                name: "TeamId",
                table: "Records",
                type: "integer",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "integer",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Records_Teams_TeamId",
                table: "Records",
                column: "TeamId",
                principalTable: "Teams",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Records_Teams_TeamId",
                table: "Records");

            migrationBuilder.AlterColumn<int>(
                name: "TeamId",
                table: "Records",
                type: "integer",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "integer");

            migrationBuilder.AddForeignKey(
                name: "FK_Records_Teams_TeamId",
                table: "Records",
                column: "TeamId",
                principalTable: "Teams",
                principalColumn: "Id");
        }
    }
}
