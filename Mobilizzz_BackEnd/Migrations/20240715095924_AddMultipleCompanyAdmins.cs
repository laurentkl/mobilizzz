using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Mobilizzz_BackEnd.Migrations
{
    /// <inheritdoc />
    public partial class AddMultipleCompanyAdmins : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Users_Companies_CompanyId",
                table: "Users");

            migrationBuilder.DropIndex(
                name: "IX_Users_CompanyId",
                table: "Users");

            migrationBuilder.CreateTable(
                name: "AdminCompany",
                columns: table => new
                {
                    AdminsId = table.Column<int>(type: "integer", nullable: false),
                    CompaniesOwnerShipId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AdminCompany", x => new { x.AdminsId, x.CompaniesOwnerShipId });
                    table.ForeignKey(
                        name: "FK_AdminCompany_Companies_CompaniesOwnerShipId",
                        column: x => x.CompaniesOwnerShipId,
                        principalTable: "Companies",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AdminCompany_Users_AdminsId",
                        column: x => x.AdminsId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AdminCompany_CompaniesOwnerShipId",
                table: "AdminCompany",
                column: "CompaniesOwnerShipId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AdminCompany");

            migrationBuilder.CreateIndex(
                name: "IX_Users_CompanyId",
                table: "Users",
                column: "CompanyId");

            migrationBuilder.AddForeignKey(
                name: "FK_Users_Companies_CompanyId",
                table: "Users",
                column: "CompanyId",
                principalTable: "Companies",
                principalColumn: "Id");
        }
    }
}
