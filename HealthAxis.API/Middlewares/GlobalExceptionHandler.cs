using HealthAxis.API.Exceptions;
using HealthAxis.Shared.Dtos;
using Microsoft.AspNetCore.Diagnostics;

namespace HealthAxis.API.Middlewares;

public class GlobalExceptionHandler(
    ILogger<GlobalExceptionHandler> logger) : IExceptionHandler
{
    public async ValueTask<bool> TryHandleAsync(
        HttpContext httpContext,
        Exception exception,
        CancellationToken cancellationToken)
    {
        var (statusCode, message) = MapException(exception);

        if (statusCode >= StatusCodes.Status500InternalServerError)
        {
            logger.LogError(
                exception,
                "Request processing failed. Method={RequestMethod}, Path={RequestPath}, StatusCode={StatusCode}",
                httpContext.Request.Method,
                httpContext.Request.Path,
                statusCode);
        }
        else
        {
            logger.LogWarning(
                "Request rejected. Method={RequestMethod}, Path={RequestPath}, StatusCode={StatusCode}, ErrorType={ErrorType}, ErrorMessage={ErrorMessage}",
                httpContext.Request.Method,
                httpContext.Request.Path,
                statusCode,
                exception.GetType().Name,
                message);
        }

        var response = new ErrorResponseDto
        {
            StatusCode = statusCode,
            Message = message,
            Details = statusCode >= StatusCodes.Status500InternalServerError
                ? "InternalServerError"
                : exception.GetType().Name,
            Timestamp = DateTime.UtcNow,
            Path = httpContext.Request.Path
        };

        httpContext.Response.StatusCode = statusCode;

        await httpContext.Response.WriteAsJsonAsync(
            response,
            cancellationToken);

        return true;
    }

    private static (int StatusCode, string Message) MapException(
        Exception exception)
    {
        return exception switch
        {
            AppException appException =>
                (appException.StatusCode, appException.Message),

            ArgumentNullException =>
                (StatusCodes.Status400BadRequest, exception.Message),

            ArgumentException =>
                (StatusCodes.Status400BadRequest, exception.Message),

            InvalidOperationException =>
                (StatusCodes.Status400BadRequest, exception.Message),

            KeyNotFoundException =>
                (StatusCodes.Status404NotFound, exception.Message),

            UnauthorizedAccessException =>
                (StatusCodes.Status403Forbidden, exception.Message),

            _ =>
                (StatusCodes.Status500InternalServerError,
                    "An unexpected error occurred.")
        };
    }
}
