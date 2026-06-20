using System.Text.Json.Serialization;

namespace HealthAxis.Admin.Models;

public class ApiErrorResponse
{
    [JsonPropertyName("statusCode")]
    public int StatusCode { get; set; }

    [JsonPropertyName("message")]
    public string Message { get; set; } = string.Empty;
}
