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

            return TryReadStringProperty(root, "message")
                ?? TryReadStringProperty(root, "detail")
                ?? TryReadStringProperty(root, "title");
        }
        catch (JsonException)
        {
            return null;
        }
    }

    private static string? TryReadStringProperty(JsonElement root, string propertyName)
    {
        return root.TryGetProperty(propertyName, out var element) &&
            element.ValueKind == JsonValueKind.String
                ? CleanMessage(element.GetString())
                : null;
    }

    private static string? TryReadValidationProblemDetailsMessage(string content)
    {
        try
        {
            using var document = JsonDocument.Parse(content);
            var root = document.RootElement;

            if (!TryGetErrorsElement(root, out var errorsElement))
            {
                return null;
            }

            var messages = errorsElement
                .EnumerateObject()
                .Select(errorProperty => errorProperty.Value)
                .Where(errorValue => errorValue.ValueKind == JsonValueKind.Array)
                .SelectMany(errorValue => errorValue.EnumerateArray())
                .Where(errorItem => errorItem.ValueKind == JsonValueKind.String)
                .Select(errorItem => CleanMessage(errorItem.GetString()))
                .Where(message => !string.IsNullOrWhiteSpace(message))
                .ToList();

            return messages.Count == 0
                ? null
                : string.Join(" ", messages);
        }
        catch (JsonException)
        {
            return null;
        }
    }

    private static bool TryGetErrorsElement(JsonElement root, out JsonElement errorsElement)
    {
        errorsElement = default;

        return root.ValueKind == JsonValueKind.Object &&
            root.TryGetProperty("errors", out errorsElement) &&
            errorsElement.ValueKind == JsonValueKind.Object;
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
