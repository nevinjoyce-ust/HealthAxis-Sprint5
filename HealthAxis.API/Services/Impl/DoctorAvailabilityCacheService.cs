using System.Text.Json;
using HealthAxis.Shared.Dtos.Doctor;
using Microsoft.Extensions.Caching.Distributed;

namespace HealthAxis.API.Services.Impl;

public class DoctorAvailabilityCacheService(
    IDistributedCache cache,
    ILogger<DoctorAvailabilityCacheService> logger) : IDoctorAvailabilityCacheService
{
    private static readonly DistributedCacheEntryOptions CacheOptions = new()
    {
        AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(5)
    };

    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);

    public async Task<DoctorAvailableSlotsDto?> GetDoctorSlotsAsync(int doctorId, DateOnly date)
    {
        var cacheKey = BuildCacheKey(doctorId, date);
        var cachedValue = await cache.GetStringAsync(cacheKey);

        if (string.IsNullOrWhiteSpace(cachedValue))
        {
            logger.LogInformation(
                "Redis cache MISS for doctor availability. Key={CacheKey}",
                cacheKey);

            return null;
        }

        logger.LogInformation(
            "Redis cache HIT for doctor availability. Key={CacheKey}",
            cacheKey);

        return JsonSerializer.Deserialize<DoctorAvailableSlotsDto>(cachedValue, JsonOptions);
    }

    public async Task SetDoctorSlotsAsync(int doctorId, DateOnly date, DoctorAvailableSlotsDto slots)
    {
        var cacheKey = BuildCacheKey(doctorId, date);
        var serializedValue = JsonSerializer.Serialize(slots, JsonOptions);

        await cache.SetStringAsync(cacheKey, serializedValue, CacheOptions);

        logger.LogInformation(
            "Doctor availability cached in Redis. Key={CacheKey}, TtlMinutes={TtlMinutes}",
            cacheKey,
            5);
    }

    public async Task RemoveDoctorSlotsAsync(int doctorId, DateOnly date)
    {
        var cacheKey = BuildCacheKey(doctorId, date);

        await cache.RemoveAsync(cacheKey);

        logger.LogInformation(
            "Doctor availability cache invalidated. Key={CacheKey}",
            cacheKey);
    }

    public async Task RemoveDoctorAvailabilityRangeAsync(int doctorId, int monthsAhead)
    {
        var startDate = DateOnly.FromDateTime(DateTime.Today);
        var endDate = startDate.AddMonths(monthsAhead);

        for (var date = startDate; date <= endDate; date = date.AddDays(1))
        {
            await RemoveDoctorSlotsAsync(doctorId, date);
        }
    }

    private static string BuildCacheKey(int doctorId, DateOnly date)
    {
        return $"doctors:{doctorId}:availability:{date:yyyy-MM-dd}";
    }
}
