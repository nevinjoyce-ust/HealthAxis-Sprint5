using System.Net.Http.Json;
using HealthAxis.Shared.Dtos;

namespace HealthAxis.Admin.Services.Impl;

public class AdminDashboardService : IAdminDashboardService
{
    private readonly HttpClient _httpClient;

    public AdminDashboardService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<AdminDashboardSummaryDto> GetDashboardSummaryAsync()
    {
        return await _httpClient.GetFromJsonAsync<AdminDashboardSummaryDto>("api/admin/dashboard-summary")
            ?? new AdminDashboardSummaryDto();
    }
}
