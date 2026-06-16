using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HealthAxis.API.Migrations
{
    /// <inheritdoc />
    public partial class ImprovedEntityProperties : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ExperienceYears",
                table: "Doctors");

            migrationBuilder.DropColumn(
                name: "CreatedAt",
                table: "Appointments");

            migrationBuilder.AddColumn<DateOnly>(
                name: "PracticeStartDate",
                table: "Doctors",
                type: "date",
                nullable: false,
                defaultValue: new DateOnly(1, 1, 1));

            migrationBuilder.UpdateData(
                table: "Doctors",
                keyColumn: "Id",
                keyValue: 1,
                column: "PracticeStartDate",
                value: new DateOnly(2015, 1, 1));

            migrationBuilder.UpdateData(
                table: "Doctors",
                keyColumn: "Id",
                keyValue: 2,
                column: "PracticeStartDate",
                value: new DateOnly(2019, 1, 1));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PracticeStartDate",
                table: "Doctors");

            migrationBuilder.AddColumn<int>(
                name: "ExperienceYears",
                table: "Doctors",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<DateTime>(
                name: "CreatedAt",
                table: "Appointments",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Doctors",
                keyColumn: "Id",
                keyValue: 1,
                column: "ExperienceYears",
                value: 8);

            migrationBuilder.UpdateData(
                table: "Doctors",
                keyColumn: "Id",
                keyValue: 2,
                column: "ExperienceYears",
                value: 5);
        }
    }
}
