using HealthAxis.Shared.Dtos;

namespace HealthAxis.Admin.Services;

public interface IAdminDashboardService
{
    Task<AdminDashboardSummaryDto> GetDashboardSummaryAsync();
}
