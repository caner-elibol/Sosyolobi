using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Reports;
using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Enums;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class ReportService : IReportService
{
    private readonly AppDbContext _db;

    public ReportService(AppDbContext db) => _db = db;

    public async Task<ReportResponse> CreateAsync(Guid reporterUserId, CreateReportRequest request)
    {
        if (request.ReportedUserId is null && request.ReportedActivityId is null)
            throw new ArgumentException("Raporlanan kullanıcı veya etkinlik belirtilmelidir.");

        var report = new Report
        {
            Id = Guid.CreateVersion7(),
            ReporterUserId = reporterUserId,
            ReportedUserId = request.ReportedUserId,
            ReportedActivityId = request.ReportedActivityId,
            Reason = request.Reason,
            Details = request.Details,
            Status = ReportStatus.Pending,
            CreatedAt = DateTime.UtcNow
        };
        _db.Reports.Add(report);
        await _db.SaveChangesAsync();

        return MapToResponse(report);
    }

    public async Task<PagedResponse<ReportResponse>> GetAllAsync(PagedRequest paged)
    {
        var query = _db.Reports.OrderByDescending(r => r.CreatedAt);
        var total = await query.CountAsync();
        var items = await query.Skip((paged.Page - 1) * paged.PageSize).Take(paged.PageSize).ToListAsync();

        return new PagedResponse<ReportResponse>
        {
            Items = items.Select(MapToResponse).ToList(),
            TotalCount = total,
            Page = paged.Page,
            PageSize = paged.PageSize
        };
    }

    public async Task ResolveAsync(Guid reportId)
    {
        var report = await _db.Reports.FindAsync(reportId)
            ?? throw new KeyNotFoundException("Rapor bulunamadı.");

        report.Status = ReportStatus.Resolved;
        report.ResolvedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();
    }

    private static ReportResponse MapToResponse(Report r) => new()
    {
        Id = r.Id,
        ReporterUserId = r.ReporterUserId,
        ReportedUserId = r.ReportedUserId,
        ReportedActivityId = r.ReportedActivityId,
        Reason = r.Reason,
        Details = r.Details,
        Status = r.Status,
        CreatedAt = r.CreatedAt,
        ResolvedAt = r.ResolvedAt
    };
}
