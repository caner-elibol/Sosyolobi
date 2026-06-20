using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Reports;

namespace Sosyolobi.Api.Services.Interfaces;

public interface IReportService
{
    Task<ReportResponse> CreateAsync(Guid reporterUserId, CreateReportRequest request);
    Task<PagedResponse<ReportResponse>> GetAllAsync(PagedRequest paged);
    Task ResolveAsync(Guid reportId);
}
