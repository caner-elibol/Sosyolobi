using Sosyolobi.Api.DTOs.Activities;
using Sosyolobi.Api.DTOs.Common;

namespace Sosyolobi.Api.Services.Interfaces;

public interface IActivityService
{
    Task<ActivityResponse> CreateAsync(Guid userId, CreateActivityRequest request);
    Task<PagedResponse<ActivityResponse>> GetListAsync(PagedRequest paged);
    Task<IList<ActivityResponse>> GetNearbyAsync(NearbyActivitiesRequest request);
    Task<IList<ActivityMapItemResponse>> GetMapItemsAsync(NearbyActivitiesRequest request);
    Task<ActivityDetailResponse?> GetByIdAsync(Guid id, Guid? requestingUserId);
    Task<ActivityResponse> UpdateAsync(Guid id, Guid userId, UpdateActivityRequest request);
    Task DeleteAsync(Guid id, Guid userId);
    Task CancelAsync(Guid id, Guid userId);
    Task CompleteAsync(Guid id, Guid userId);
}
