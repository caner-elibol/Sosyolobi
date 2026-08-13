import 'package:freezed_annotation/freezed_annotation.dart';

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
