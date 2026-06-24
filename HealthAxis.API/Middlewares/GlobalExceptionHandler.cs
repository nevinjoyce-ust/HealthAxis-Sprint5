using HealthAxis.Shared.Dtos;
using HealthAxis.API.Exceptions;
using Microsoft.AspNetCore.Diagnostics;

namespace HealthAxis.API.Middlewares;

public class GlobalExceptionHandler(ILogger<GlobalExceptionHandler> logger) : IExceptionHandler
{
    public async ValueTask<bool> TryHandleAsync(
        HttpContext httpContext,
        Exception exception,
        CancellationToken cancellationToken)
    {
        logger.LogError(
            exception,
            "An unexpected error occurred: {Message}",
            exception.Message
        );

        var (statusCode, message) = exception switch
        {
            AppException appException => (appException.StatusCode, appException.Message),
            ArgumentNullException => (StatusCodes.Status400BadRequest, exception.Message),
            ArgumentException => (StatusCodes.Status400BadRequest, exception.Message),
            InvalidOperationException => (StatusCodes.Status400BadRequest, exception.Message),
            KeyNotFoundException => (StatusCodes.Status404NotFound, exception.Message),
            UnauthorizedAccessException => (StatusCodes.Status403Forbidden, exception.Message),
            _ => (StatusCodes.Status500InternalServerError, "An unexpected error occurred.")
        };

        var response = new ErrorResponseDto
        {
            StatusCode = statusCode,
            Message = message,
            Details = exception.GetType().Name,
            Timestamp = DateTime.UtcNow,
            Path = httpContext.Request.Path
        };

        httpContext.Response.StatusCode = statusCode;

        await httpContext.Response.WriteAsJsonAsync(response, cancellationToken);

        return true;
    }
}
