using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Entities;

namespace Sosyolobi.Api.Data;

public static class SeedData
{
    public static async Task SeedAsync(AppDbContext db)
    {
        if (await db.ActivityCategories.AnyAsync())
            return;

        var categories = new List<ActivityCategory>
        {
            new() { Id = Guid.NewGuid(), Name = "Futbol",                  Slug = "futbol",               IconName = "soccer",    Color = "#2ECC71", SortOrder = 1 },
            new() { Id = Guid.NewGuid(), Name = "Basketbol",               Slug = "basketbol",            IconName = "basketball",Color = "#E67E22", SortOrder = 2 },
            new() { Id = Guid.NewGuid(), Name = "Voleybol",                Slug = "voleybol",             IconName = "volleyball",Color = "#3498DB", SortOrder = 3 },
            new() { Id = Guid.NewGuid(), Name = "Tenis",                   Slug = "tenis",                IconName = "tennis",    Color = "#F1C40F", SortOrder = 4 },
            new() { Id = Guid.NewGuid(), Name = "Koşu",                    Slug = "kosu",                 IconName = "run",       Color = "#E74C3C", SortOrder = 5 },
            new() { Id = Guid.NewGuid(), Name = "Bisiklet",                Slug = "bisiklet",             IconName = "bike",      Color = "#9B59B6", SortOrder = 6 },
            new() { Id = Guid.NewGuid(), Name = "Yürüyüş",                 Slug = "yuruyus",              IconName = "hiking",    Color = "#1ABC9C", SortOrder = 7 },
            new() { Id = Guid.NewGuid(), Name = "Kamp",                    Slug = "kamp",                 IconName = "camping",   Color = "#27AE60", SortOrder = 8 },
            new() { Id = Guid.NewGuid(), Name = "Kayak",                   Slug = "kayak",                IconName = "ski",       Color = "#5DADE2", SortOrder = 9 },
            new() { Id = Guid.NewGuid(), Name = "Masa Oyunu",              Slug = "masa-oyunu",           IconName = "game",      Color = "#E59866", SortOrder = 10 },
            new() { Id = Guid.NewGuid(), Name = "Konser",                  Slug = "konser",               IconName = "music",     Color = "#A569BD", SortOrder = 11 },
            new() { Id = Guid.NewGuid(), Name = "Kahve & Sosyal Buluşma",  Slug = "kahve-sosyal",         IconName = "coffee",    Color = "#D35400", SortOrder = 12 },
            new() { Id = Guid.NewGuid(), Name = "Diğer",                   Slug = "diger",                IconName = "other",     Color = "#95A5A6", SortOrder = 13 },
        };

        await db.ActivityCategories.AddRangeAsync(categories);
        await db.SaveChangesAsync();
    }
}
