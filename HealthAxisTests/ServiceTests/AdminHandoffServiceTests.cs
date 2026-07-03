using HealthAxis.API.Services.Impl;
using Microsoft.Extensions.Caching.Memory;

namespace HealthAxisTests.ServiceTests;

public class AdminHandoffServiceTests
{
    [Fact]
    public void CreateCode_ShouldReturnNonEmptyCodeAndStoreUserIdUntilConsumed()
    {
        using var cache = new MemoryCache(new MemoryCacheOptions());
        var service = new AdminHandoffService(cache);

        var code = service.CreateCode("admin-user-id");

        Assert.False(string.IsNullOrWhiteSpace(code));
        Assert.DoesNotContain("+", code);
        Assert.DoesNotContain("/", code);
        Assert.DoesNotContain("=", code);

        var consumedUserId = service.ConsumeCode(code);

        Assert.Equal("admin-user-id", consumedUserId);
    }

    [Fact]
    public void ConsumeCode_WhenCodeDoesNotExist_ShouldReturnNull()
    {
        using var cache = new MemoryCache(new MemoryCacheOptions());
        var service = new AdminHandoffService(cache);

        var result = service.ConsumeCode("missing-code");

        Assert.Null(result);
    }

    [Fact]
    public void ConsumeCode_WhenCodeIsConsumedTwice_ShouldReturnUserIdOnlyOnce()
    {
        using var cache = new MemoryCache(new MemoryCacheOptions());
        var service = new AdminHandoffService(cache);

        var code = service.CreateCode("admin-user-id");

        var firstResult = service.ConsumeCode(code);
        var secondResult = service.ConsumeCode(code);

        Assert.Equal("admin-user-id", firstResult);
        Assert.Null(secondResult);
    }

    [Fact]
    public void CreateCode_WhenCalledMultipleTimes_ShouldCreateDifferentCodes()
    {
        using var cache = new MemoryCache(new MemoryCacheOptions());
        var service = new AdminHandoffService(cache);

        var firstCode = service.CreateCode("admin-user-id");
        var secondCode = service.CreateCode("admin-user-id");

        Assert.NotEqual(firstCode, secondCode);
        Assert.Equal("admin-user-id", service.ConsumeCode(firstCode));
        Assert.Equal("admin-user-id", service.ConsumeCode(secondCode));
    }
}
