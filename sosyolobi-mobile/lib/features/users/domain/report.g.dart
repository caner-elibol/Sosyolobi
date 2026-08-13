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
