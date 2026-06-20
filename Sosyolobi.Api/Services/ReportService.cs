using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Admin;
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

    public async Task<PagedResponse<ReportResponse>> GetAllAsync(AdminReportFilterRequest filter)
    {
        var query = _db.Reports.AsQueryable();

        if (filter.Status.HasValue)
            query = query.Where(r => r.Status == filter.Status.Value);

        query = query.OrderByDescending(r => r.CreatedAt);
        var total = await query.CountAsync();
        var items = await query
            .Skip((filter.Page - 1) * filter.PageSize)
            .Take(filter.PageSize)
            .ToListAsync();

        return new PagedResponse<ReportResponse>
        {
            Items = items.Select(MapToResponse).ToList(),
            TotalCount = total,
            Page = filter.Page,
            PageSize = filter.PageSize
        };
    }

    public async Task<ReportResponse> GetByIdAsync(Guid reportId)
    {
        var report = await _db.Reports.FindAsync(reportId)
            ?? throw new KeyNotFoundException("Rapor bulunamadı.");
        return MapToResponse(report);
    }

    public async Task ResolveAsync(Guid reportId)
    {
        var report = await _db.Reports.FindAsync(reportId)
            ?? throw new KeyNotFoundException("Rapor bulunamadı.");

        report.Status = ReportStatus.Resolved;
        report.ResolvedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();
    }

    public async Task UpdateStatusAsync(Guid reportId, ReportStatus status, string? adminNote)
    {
        var report = await _db.Reports.FindAsync(reportId)
            ?? throw new KeyNotFoundException("Rapor bulunamadı.");

        report.Status = status;
        if (status == ReportStatus.Resolved || status == ReportStatus.Dismissed)
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
