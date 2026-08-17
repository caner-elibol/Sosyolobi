// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateReportRequestImpl _$$CreateReportRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateReportRequestImpl(
  reportedUserId: json['reportedUserId'] as String?,
  reportedActivityId: json['reportedActivityId'] as String?,
  reason: json['reason'] as String,
  details: json['details'] as String?,
);

Map<String, dynamic> _$$CreateReportRequestImplToJson(
  _$CreateReportRequestImpl instance,
) => <String, dynamic>{
  'reportedUserId': instance.reportedUserId,
  'reportedActivityId': instance.reportedActivityId,
  'reason': instance.reason,
  'details': instance.details,
};

_$ReportResponseImpl _$$ReportResponseImplFromJson(Map<String, dynamic> json) =>
    _$ReportResponseImpl(
      id: json['id'] as String,
      reporterUserId: json['reporterUserId'] as String,
      reportedUserId: json['reportedUserId'] as String?,
      reportedActivityId: json['reportedActivityId'] as String?,
      reason: json['reason'] as String,
      details: json['details'] as String?,
      status: const ReportStatusConverter().fromJson(
        (json['status'] as num).toInt(),
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
    );

Map<String, dynamic> _$$ReportResponseImplToJson(
  _$ReportResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'reporterUserId': instance.reporterUserId,
  'reportedUserId': instance.reportedUserId,
  'reportedActivityId': instance.reportedActivityId,
  'reason': instance.reason,
  'details': instance.details,
  'status': const ReportStatusConverter().toJson(instance.status),
  'createdAt': instance.createdAt.toIso8601String(),
  'resolvedAt': instance.resolvedAt?.toIso8601String(),
};
