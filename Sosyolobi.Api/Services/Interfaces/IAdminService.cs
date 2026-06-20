using Sosyolobi.Api.DTOs.Activities;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Profiles;

namespace Sosyolobi.Api.Services.Interfaces;

public interface IAdminService
{
    Task<PagedResponse<ProfileResponse>> GetUsersAsync(PagedRequest paged);
    Task<PagedResponse<ActivityResponse>> GetActivitiesAsync(PagedRequest paged);
    Task SuspendUserAsync(Guid userId);
    Task ActivateUserAsync(Guid userId);
}
