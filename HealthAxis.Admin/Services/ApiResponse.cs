namespace HealthAxis.Admin.Services;

public class ApiResponse<T>
{
    public bool IsSuccess { get; init; }

    public T? Data { get; init; }

    public string? ErrorMessage { get; init; }

    public static ApiResponse<T> Success(T? data)
    {
        return new ApiResponse<T>
        {
            IsSuccess = true,
            Data = data
        };
    }

    public static ApiResponse<T> Failure(string errorMessage)
    {
        return new ApiResponse<T>
        {
            IsSuccess = false,
            ErrorMessage = errorMessage
        };
    }
}
