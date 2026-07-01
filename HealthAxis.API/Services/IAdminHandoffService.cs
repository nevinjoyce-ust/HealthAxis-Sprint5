namespace HealthAxis.API.Services;

public interface IAdminHandoffService
{
    string CreateCode(string userId);

    string? ConsumeCode(string code);
}