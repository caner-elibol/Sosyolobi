using Microsoft.EntityFrameworkCore;

namespace Sosyolobi.Api.Data;

public static class DbInitializer
{
    public static async Task InitializeAsync(IServiceProvider serviceProvider)
    {
        using var scope = serviceProvider.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();

        await db.Database.MigrateAsync();
        await SeedData.SeedAsync(db);
    }
}
