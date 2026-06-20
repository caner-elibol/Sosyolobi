using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Extensions;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api/profiles")]
[Authorize]
public class ProfilesController : ControllerBase
{
    private readonly IProfileService _profileService;

    public ProfilesController(IProfileService profileService) => _profileService = profileService;

    [HttpGet("me")]
    public async Task<IActionResult> GetMyProfile()
    {
        var userId = User.GetUserId();
        var result = await _profileService.GetMyProfileAsync(userId);
        if (result is null) return NotFound();
        return Ok(ApiResponse<ProfileResponse>.Ok(result));
    }

    [HttpPut("me")]
    public async Task<IActionResult> UpdateMyProfile([FromBody] UpdateProfileRequest request)
    {
        var userId = User.GetUserId();
        var result = await _profileService.UpdateProfileAsync(userId, request);
        return Ok(ApiResponse<ProfileResponse>.Ok(result));
    }

    [HttpGet("{userId:guid}")]
    [AllowAnonymous]
    public async Task<IActionResult> GetPublicProfile(Guid userId)
    {
        var result = await _profileService.GetMyProfileAsync(userId);
        if (result is null) return NotFound();
        return Ok(ApiResponse<PublicProfileResponse>.Ok(new PublicProfileResponse
        {
            UserId = result.UserId,
            DisplayName = result.DisplayName,
            Bio = result.Bio,
            AvatarUrl = result.AvatarUrl,
            AverageRating = result.AverageRating,
            ReviewCount = result.ReviewCount,
            CompletedActivityCount = result.CompletedActivityCount
        }));
    }
}
