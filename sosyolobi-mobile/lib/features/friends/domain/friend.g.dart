// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendImpl _$$FriendImplFromJson(Map<String, dynamic> json) => _$FriendImpl(
  friendsSinceUtc: DateTime.parse(json['friendsSinceUtc'] as String),
  user: PublicProfile.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$FriendImplToJson(_$FriendImpl instance) =>
    <String, dynamic>{
      'friendsSinceUtc': instance.friendsSinceUtc.toIso8601String(),
      'user': instance.user,
    };

_$FriendRequestImpl _$$FriendRequestImplFromJson(Map<String, dynamic> json) =>
    _$FriendRequestImpl(
      id: json['id'] as String,
      status: const FriendRequestStatusConverter().fromJson(
        (json['status'] as num).toInt(),
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      respondedAt: json['respondedAt'] == null
          ? null
          : DateTime.parse(json['respondedAt'] as String),
      user: PublicProfile.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FriendRequestImplToJson(_$FriendRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': const FriendRequestStatusConverter().toJson(instance.status),
      'createdAt': instance.createdAt.toIso8601String(),
      'respondedAt': instance.respondedAt?.toIso8601String(),
      'user': instance.user,
    };
