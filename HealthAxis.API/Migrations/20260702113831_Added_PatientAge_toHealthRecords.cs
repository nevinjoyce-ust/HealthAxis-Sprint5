using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HealthAxis.API.Migrations
{
    /// <inheritdoc />
    public partial class Added_PatientAge_toHealthRecords : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "PatientAge",
                table: "HealthRecords",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PatientAge",
                table: "HealthRecords");
        }
    }
}
