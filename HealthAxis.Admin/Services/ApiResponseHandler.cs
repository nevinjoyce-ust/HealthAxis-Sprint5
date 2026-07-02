using System.Net.Http.Json;
using System.Text.Json;

namespace HealthAxis.Admin.Services;

public static class ApiResponseHandler
{
    public static async Task<ApiResponse<T>> ReadResponseAsync<T>(
        HttpResponseMessage response,
        string fallbackErrorMessage)
    {
        if (response.IsSuccessStatusCode)
        {
            var data = await response.Content.ReadFromJsonAsync<T>();
            return ApiResponse<T>.Success(data);
        }

        var errorMessage = await ReadErrorMessageAsync(response, fallbackErrorMessage);
        return ApiResponse<T>.Failure(errorMessage);
    }

    public static async Task<ApiResponse<string>> ReadMessageResponseAsync(
        HttpResponseMessage response,
        string fallbackErrorMessage,
        string fallbackSuccessMessage = "Operation completed successfully.")
    {
        if (response.IsSuccessStatusCode)
        {
            var content = await response.Content.ReadAsStringAsync();
            var message = ExtractMessage(content) ?? fallbackSuccessMessage;

            return ApiResponse<string>.Success(message);
        }

        var errorMessage = await ReadErrorMessageAsync(response, fallbackErrorMessage);
        return ApiResponse<string>.Failure(errorMessage);
    }

    public static async Task<string> ReadErrorMessageAsync(
        HttpResponseMessage response,
        string fallbackErrorMessage)
    {
        var content = await response.Content.ReadAsStringAsync();

        if (string.IsNullOrWhiteSpace(content))
        {
            return fallbackErrorMessage;
        }

        var errorMessage = ExtractMessage(content);

        return string.IsNullOrWhiteSpace(errorMessage)
            ? fallbackErrorMessage
            : errorMessage;
    }

    private static string? ExtractMessage(string? content)
    {
        if (string.IsNullOrWhiteSpace(content))
        {
            return null;
        }

        return TryReadValidationProblemDetailsMessage(content)
            ?? TryReadJsonMessage(content)
            ?? CleanMessage(content);
    }

    private static string? TryReadJsonMessage(string content)
    {
        try
        {
            using var document = JsonDocument.Parse(content);
            var root = document.RootElement;

            if (root.ValueKind == JsonValueKind.String)
            {
                return CleanMessage(root.GetString());
            }

            if (root.ValueKind != JsonValueKind.Object)
            {
                return null;
            }

            if (root.TryGetProperty("message", out var messageElement) &&
                messageElement.ValueKind == JsonValueKind.String)
            {
                return CleanMessage(messageElement.GetString());
            }

            if (root.TryGetProperty("detail", out var detailElement) &&
                detailElement.ValueKind == JsonValueKind.String)
            {
                return CleanMessage(detailElement.GetString());
            }

            if (root.TryGetProperty("title", out var titleElement) &&
                titleElement.ValueKind == JsonValueKind.String)
            {
                return CleanMessage(titleElement.GetString());
            }

            return null;
        }
        catch (JsonException)
        {
            return null;
        }
    }

    private static string? TryReadValidationProblemDetailsMessage(string content)
    {
        try
        {
            using var document = JsonDocument.Parse(content);
            var root = document.RootElement;

            if (root.ValueKind != JsonValueKind.Object ||
                !root.TryGetProperty("errors", out var errorsElement) ||
                errorsElement.ValueKind != JsonValueKind.Object)
            {
                return null;
            }

            var messages = new List<string>();

            foreach (var errorProperty in errorsElement.EnumerateObject())
            {
                if (errorProperty.Value.ValueKind != JsonValueKind.Array)
                {
                    continue;
                }

                foreach (var errorItem in errorProperty.Value.EnumerateArray())
                {
                    if (errorItem.ValueKind == JsonValueKind.String)
                    {
                        var message = CleanMessage(errorItem.GetString());

                        if (!string.IsNullOrWhiteSpace(message))
                        {
                            messages.Add(message);
                        }
                    }
                }
            }

            return messages.Count == 0
                ? null
                : string.Join(" ", messages);
        }
        catch (JsonException)
        {
            return null;
        }
    }

    private static string CleanMessage(string? message)
    {
        if (string.IsNullOrWhiteSpace(message))
        {
            return string.Empty;
        }

        return message.Trim().Trim('"');
    }
}
