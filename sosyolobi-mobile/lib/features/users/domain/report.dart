import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/enum_converters.dart';
import '../../../core/domain/enums.dart';

part 'report.freezed.dart';
part 'report.g.dart';

/// Mirrors `Sosyolobi.Api/DTOs/Reports/CreateReportRequest.cs` — payload for
/// `ReportUserModal`'s "Kullanıcıyı Bildir" flow (`ParticipantActionsMenu`).
@freezed
abstract class CreateReportRequest with _$CreateReportRequest {
  const factory CreateReportRequest({
    String? reportedUserId,
    String? reportedActivityId,
    required String reason,
    String? details,
  }) = _CreateReportRequest;

  factory CreateReportRequest.fromJson(Map<String, dynamic> json) => _$CreateReportRequestFromJson(json);
}

/// Mirrors `Sosyolobi.Api/DTOs/Reports/ReportResponse.cs` — used by the
/// `GET /api/reports/mine` "Raporlarım" list.
@freezed
abstract class ReportResponse with _$ReportResponse {
  const factory ReportResponse({
    required String id,
    required String reporterUserId,
    String? reportedUserId,
    String? reportedActivityId,
    required String reason,
    String? details,
    @ReportStatusConverter() required ReportStatus status,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) = _ReportResponse;

  factory ReportResponse.fromJson(Map<String, dynamic> json) => _$ReportResponseFromJson(json);
}
