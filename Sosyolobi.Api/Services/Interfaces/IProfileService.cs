using Sosyolobi.Api.DTOs.Profiles;

namespace Sosyolobi.Api.Services.Interfaces;

public interface IProfileService
{
    Task<ProfileResponse?> GetMyProfileAsync(Guid userId);
    Task<ProfileResponse> UpdateProfileAsync(Guid userId, UpdateProfileRequest request);
}
