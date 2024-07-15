﻿using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Mobilizzz_BackEnd.Migrations
{
    /// <inheritdoc />
    public partial class AddVisibleAndPrivateOnTeam3 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsHidden",
                table: "Teams",
                type: "boolean",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsHidden",
                table: "Teams");
        }
    }
}
