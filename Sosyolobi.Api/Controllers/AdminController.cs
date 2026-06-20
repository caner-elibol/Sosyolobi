using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.Activities;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.DTOs.Reports;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api/admin")]
[Authorize(Roles = "Admin")]
public class AdminController : ControllerBase
{
    private readonly IAdminService _adminService;
    private readonly IReportService _reportService;

    public AdminController(IAdminService adminService, IReportService reportService)
    {
        _adminService = adminService;
        _reportService = reportService;
    }

    [HttpGet("users")]
    public async Task<IActionResult> GetUsers([FromQuery] PagedRequest paged)
    {
        var result = await _adminService.GetUsersAsync(paged);
        return Ok(ApiResponse<PagedResponse<ProfileResponse>>.Ok(result));
    }

    [HttpGet("activities")]
    public async Task<IActionResult> GetActivities([FromQuery] PagedRequest paged)
    {
        var result = await _adminService.GetActivitiesAsync(paged);
        return Ok(ApiResponse<PagedResponse<ActivityResponse>>.Ok(result));
    }

    [HttpPost("users/{id:guid}/suspend")]
    public async Task<IActionResult> Suspend(Guid id)
    {
        await _adminService.SuspendUserAsync(id);
        return Ok(ApiResponse<object>.Ok(null, "Kullanıcı askıya alındı."));
    }

    [HttpPost("users/{id:guid}/activate")]
    public async Task<IActionResult> Activate(Guid id)
    {
        await _adminService.ActivateUserAsync(id);
        return Ok(ApiResponse<object>.Ok(null, "Kullanıcı aktifleştirildi."));
    }

    [HttpGet("reports")]
    public async Task<IActionResult> GetReports([FromQuery] PagedRequest paged)
    {
        var result = await _reportService.GetAllAsync(paged);
        return Ok(ApiResponse<PagedResponse<ReportResponse>>.Ok(result));
    }

    [HttpPost("reports/{id:guid}/resolve")]
    public async Task<IActionResult> ResolveReport(Guid id)
    {
        await _reportService.ResolveAsync(id);
        return Ok(ApiResponse<object>.Ok(null, "Rapor çözüldü."));
    }
}
