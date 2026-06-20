using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class ProfileService : IProfileService
{
    private readonly AppDbContext _db;

    public ProfileService(AppDbContext db) => _db = db;

    public async Task<ProfileResponse?> GetMyProfileAsync(Guid userId)
    {
        var user = await _db.Users.Include(u => u.Profile).FirstOrDefaultAsync(u => u.Id == userId);
        if (user is null) return null;

        return Map(user);
    }

    public async Task<ProfileResponse> UpdateProfileAsync(Guid userId, UpdateProfileRequest request)
    {
        var user = await _db.Users.Include(u => u.Profile).FirstOrDefaultAsync(u => u.Id == userId)
            ?? throw new KeyNotFoundException("Kullanıcı bulunamadı.");

        if (user.Profile is null)
        {
            user.Profile = new UserProfile
            {
                Id = Guid.CreateVersion7(),
                UserId = userId,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
            _db.UserProfiles.Add(user.Profile);
        }

        user.Profile.DisplayName = request.DisplayName;
        user.Profile.Bio = request.Bio;
        user.Profile.AvatarUrl = request.AvatarUrl;
        user.Profile.BirthDate = request.BirthDate;
        user.Profile.UpdatedAt = DateTime.UtcNow;

        await _db.SaveChangesAsync();
        return Map(user);
    }

    private static ProfileResponse Map(User user) => new()
    {
        UserId = user.Id,
        DisplayName = user.Profile?.DisplayName ?? string.Empty,
        Bio = user.Profile?.Bio,
        AvatarUrl = user.Profile?.AvatarUrl,
        BirthDate = user.Profile?.BirthDate,
        AverageRating = user.Profile?.AverageRating ?? 0,
        ReviewCount = user.Profile?.ReviewCount ?? 0,
        CompletedActivityCount = user.Profile?.CompletedActivityCount ?? 0,
        IsPhoneVerified = user.IsPhoneVerified,
        CreatedAt = user.CreatedAt
    };
}
