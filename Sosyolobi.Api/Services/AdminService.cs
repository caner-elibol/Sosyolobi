using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Activities;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Enums;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class AdminService : IAdminService
{
    private readonly AppDbContext _db;

    public AdminService(AppDbContext db) => _db = db;

    public async Task<PagedResponse<ProfileResponse>> GetUsersAsync(PagedRequest paged)
    {
        var query = _db.Users.Include(u => u.Profile).OrderByDescending(u => u.CreatedAt);
        var total = await query.CountAsync();
        var items = await query.Skip((paged.Page - 1) * paged.PageSize).Take(paged.PageSize).ToListAsync();

        return new PagedResponse<ProfileResponse>
        {
            Items = items.Select(u => new ProfileResponse
            {
                UserId = u.Id,
                DisplayName = u.Profile?.DisplayName ?? string.Empty,
                Bio = u.Profile?.Bio,
                AvatarUrl = u.Profile?.AvatarUrl,
                AverageRating = u.Profile?.AverageRating ?? 0,
                ReviewCount = u.Profile?.ReviewCount ?? 0,
                CompletedActivityCount = u.Profile?.CompletedActivityCount ?? 0,
                IsPhoneVerified = u.IsPhoneVerified,
                CreatedAt = u.CreatedAt
            }).ToList(),
            TotalCount = total,
            Page = paged.Page,
            PageSize = paged.PageSize
        };
    }

   public async Task<PagedResponse<ActivityResponse>> GetActivitiesAsync(PagedRequest paged)
{
    var query = _db.Activities
        .Include(a => a.Category)
        .Include(a => a.CreatedByUser)
            .ThenInclude(u => u.Profile)
        .OrderByDescending(a => a.CreatedAt);

    var total = await query.CountAsync();

    var items = await query
        .Skip((paged.Page - 1) * paged.PageSize)
        .Take(paged.PageSize)
        .ToListAsync();

    return new PagedResponse<ActivityResponse>
    {
        Items = items.Select(a => new ActivityResponse
        {
            Id = a.Id,
            CreatedByUserId = a.CreatedByUserId,
            CreatedByDisplayName = a.CreatedByUser?.Profile?.DisplayName ?? string.Empty,
            CategoryId = a.CategoryId,
            CategoryName = a.Category?.Name ?? string.Empty,
            Title = a.Title,
            EventDate = a.EventDate,
            NeededPeopleCount = a.NeededPeopleCount,
            CurrentPeopleCount = a.CurrentPeopleCount,
            Status = a.Status,
            Latitude = a.Location.Y,
            Longitude = a.Location.X,
            AddressText = a.AddressText,
            CreatedAt = a.CreatedAt
        }).ToList(),

        TotalCount = total,
        Page = paged.Page,
        PageSize = paged.PageSize
    };
}

    public async Task SuspendUserAsync(Guid userId)
    {
        var user = await _db.Users.FindAsync(userId)
            ?? throw new KeyNotFoundException("Kullanıcı bulunamadı.");

        user.Status = UserStatus.Suspended;
        await _db.SaveChangesAsync();
    }

    public async Task ActivateUserAsync(Guid userId)
    {
        var user = await _db.Users.FindAsync(userId)
            ?? throw new KeyNotFoundException("Kullanıcı bulunamadı.");

        user.Status = UserStatus.Active;
        await _db.SaveChangesAsync();
    }
}
