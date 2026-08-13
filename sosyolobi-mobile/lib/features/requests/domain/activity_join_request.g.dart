// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_join_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityJoinRequestImpl _$$ActivityJoinRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ActivityJoinRequestImpl(
  id: json['id'] as String,
  activityId: json['activityId'] as String,
  user: PublicProfile.fromJson(json['user'] as Map<String, dynamic>),
  message: json['message'] as String?,
  status: const ActivityRequestStatusConverter().fromJson(
    (json['status'] as num).toInt(),
  ),
  createdAt: DateTime.parse(json['createdAt'] as String),
  respondedAt: json['respondedAt'] == null
      ? null
      : DateTime.parse(json['respondedAt'] as String),
);

Map<String, dynamic> _$$ActivityJoinRequestImplToJson(
  _$ActivityJoinRequestImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'activityId': instance.activityId,
  'user': instance.user,
  'message': instance.message,
  'status': const ActivityRequestStatusConverter().toJson(instance.status),
  'createdAt': instance.createdAt.toIso8601String(),
  'respondedAt': instance.respondedAt?.toIso8601String(),
};
