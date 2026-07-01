using Microsoft.Extensions.Caching.Memory;
using System.Security.Cryptography;

namespace HealthAxis.API.Services.Impl;

public class AdminHandoffService(IMemoryCache cache) : IAdminHandoffService
{
    private const int ExpirySeconds = 60;

    public string CreateCode(string userId)
    {
        var bytes = RandomNumberGenerator.GetBytes(32);
        var code = Convert.ToBase64String(bytes)
            .Replace("+", "-")
            .Replace("/", "_")
            .Replace("=", "");

        cache.Set(
            GetCacheKey(code),
            userId,
            TimeSpan.FromSeconds(ExpirySeconds));

        return code;
    }

    public string? ConsumeCode(string code)
    {
        var cacheKey = GetCacheKey(code);

        if (!cache.TryGetValue<string>(cacheKey, out var userId))
        {
            return null;
        }

        cache.Remove(cacheKey);

        return userId;
    }

    private static string GetCacheKey(string code)
    {
        return $"admin-handoff:{code}";
    }
}