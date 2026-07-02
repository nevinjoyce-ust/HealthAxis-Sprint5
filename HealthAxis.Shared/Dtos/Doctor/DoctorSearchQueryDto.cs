using HealthAxis.Shared.Enums;

namespace HealthAxis.Shared.Dtos.Doctor;

public class DoctorSearchQueryDto : PaginationQueryDto
{
    public string? Search { get; set; }

    public DoctorSpecialisation? Specialisation { get; set; }

    public bool? IsAvailable { get; set; }

    public DoctorSortBy SortBy { get; set; } = DoctorSortBy.Name;

    public SortDirection SortDirection { get; set; } = SortDirection.Asc;
}