using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Mobilizzz_BackEnd.Migrations
{
    /// <inheritdoc />
    public partial class AddTransportMethodType : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "TransportMethod",
                table: "Records");

            migrationBuilder.AddColumn<int>(
                name: "TransportMethodId",
                table: "Records",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "TransportMethod",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TransportMethod", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Records_TransportMethodId",
                table: "Records",
                column: "TransportMethodId");

            migrationBuilder.AddForeignKey(
                name: "FK_Records_TransportMethod_TransportMethodId",
                table: "Records",
                column: "TransportMethodId",
                principalTable: "TransportMethod",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Records_TransportMethod_TransportMethodId",
                table: "Records");

            migrationBuilder.DropTable(
                name: "TransportMethod");

            migrationBuilder.DropIndex(
                name: "IX_Records_TransportMethodId",
                table: "Records");

            migrationBuilder.DropColumn(
                name: "TransportMethodId",
                table: "Records");

            migrationBuilder.AddColumn<string>(
                name: "TransportMethod",
                table: "Records",
                type: "text",
                nullable: false,
                defaultValue: "");
        }
    }
}
