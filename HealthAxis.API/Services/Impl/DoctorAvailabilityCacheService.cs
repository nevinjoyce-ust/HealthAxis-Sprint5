using System.Text.Json;
using HealthAxis.Shared.Dtos.Doctor;
using Microsoft.Extensions.Caching.Distributed;

namespace HealthAxis.API.Services.Impl;

public class DoctorAvailabilityCacheService(
    IDistributedCache cache,
    ILogger<DoctorAvailabilityCacheService> logger)
    : IDoctorAvailabilityCacheService
{
    private const int CacheTtlMinutes = 5;

    private static readonly DistributedCacheEntryOptions CacheOptions = new()
    {
        AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(CacheTtlMinutes)
    };

    private static readonly JsonSerializerOptions JsonOptions =
        new(JsonSerializerDefaults.Web);

    public async Task<DoctorAvailableSlotsDto?> GetDoctorSlotsAsync(
        int doctorId,
        DateOnly date)
    {
        var cacheKey = BuildCacheKey(doctorId, date);
        var cachedValue = await cache.GetStringAsync(cacheKey);

        if (string.IsNullOrWhiteSpace(cachedValue))
        {
            if (logger.IsEnabled(LogLevel.Information))
            {
                logger.LogInformation(
                    "Doctor availability cache miss. DoctorId={DoctorId}, Date={Date}",
                    doctorId,
                    date);
            }

            return null;
        }

        if (logger.IsEnabled(LogLevel.Information))
        {
            logger.LogInformation(
                "Doctor availability cache hit. DoctorId={DoctorId}, Date={Date}",
                doctorId,
                date);
        }

        return JsonSerializer.Deserialize<DoctorAvailableSlotsDto>(
            cachedValue,
            JsonOptions);
    }

    public async Task SetDoctorSlotsAsync(
        int doctorId,
        DateOnly date,
        DoctorAvailableSlotsDto slots)
    {
        var cacheKey = BuildCacheKey(doctorId, date);
        var serializedValue = JsonSerializer.Serialize(slots, JsonOptions);

        await cache.SetStringAsync(cacheKey, serializedValue, CacheOptions);

        if (logger.IsEnabled(LogLevel.Debug))
        {
            logger.LogDebug(
                "Doctor availability cached. DoctorId={DoctorId}, Date={Date}, TtlMinutes={TtlMinutes}",
                doctorId,
                date,
                CacheTtlMinutes);
        }
    }

    public async Task RemoveDoctorSlotsAsync(int doctorId, DateOnly date)
    {
        await cache.RemoveAsync(BuildCacheKey(doctorId, date));

        if (logger.IsEnabled(LogLevel.Information))
        {
            logger.LogInformation(
                "Doctor availability cache invalidated. DoctorId={DoctorId}, Date={Date}",
                doctorId,
                date);
        }
    }

    public async Task RemoveDoctorAvailabilityRangeAsync(
        int doctorId,
        int monthsAhead)
    {
        var startDate = DateOnly.FromDateTime(DateTime.Today);
        var endDate = startDate.AddMonths(monthsAhead);

        for (var date = startDate; date <= endDate; date = date.AddDays(1))
        {
            await cache.RemoveAsync(BuildCacheKey(doctorId, date));
        }

        if (logger.IsEnabled(LogLevel.Information))
        {
            logger.LogInformation(
                "Doctor availability cache range invalidated. DoctorId={DoctorId}, StartDate={StartDate}, EndDate={EndDate}",
                doctorId,
                startDate,
                endDate);
        }
    }

    private static string BuildCacheKey(int doctorId, DateOnly date)
    {
        return $"doctors:{doctorId}:availability:{date:yyyy-MM-dd}";
    }
}
