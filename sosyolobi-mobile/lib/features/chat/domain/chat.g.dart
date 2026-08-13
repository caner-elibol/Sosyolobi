// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomImpl _$$ChatRoomImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomImpl(
      id: json['id'] as String,
      activityId: json['activityId'] as String,
      status: const ChatRoomStatusConverter().fromJson(
        (json['status'] as num).toInt(),
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      closedAt: json['closedAt'] == null
          ? null
          : DateTime.parse(json['closedAt'] as String),
    );

Map<String, dynamic> _$$ChatRoomImplToJson(_$ChatRoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activityId': instance.activityId,
      'status': const ChatRoomStatusConverter().toJson(instance.status),
      'createdAt': instance.createdAt.toIso8601String(),
      'closedAt': instance.closedAt?.toIso8601String(),
    };

_$ChatMessageReplyPreviewImpl _$$ChatMessageReplyPreviewImplFromJson(
  Map<String, dynamic> json,
) => _$ChatMessageReplyPreviewImpl(
  id: json['id'] as String,
  senderDisplayName: json['senderDisplayName'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$$ChatMessageReplyPreviewImplToJson(
  _$ChatMessageReplyPreviewImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'senderDisplayName': instance.senderDisplayName,
  'content': instance.content,
};

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      chatRoomId: json['chatRoomId'] as String,
      senderUserId: json['senderUserId'] as String,
      senderDisplayName: json['senderDisplayName'] as String,
      senderAvatarUrl: json['senderAvatarUrl'] as String?,
      content: json['content'] as String,
      replyTo: json['replyTo'] == null
          ? null
          : ChatMessageReplyPreview.fromJson(
              json['replyTo'] as Map<String, dynamic>,
            ),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatRoomId': instance.chatRoomId,
      'senderUserId': instance.senderUserId,
      'senderDisplayName': instance.senderDisplayName,
      'senderAvatarUrl': instance.senderAvatarUrl,
      'content': instance.content,
      'replyTo': instance.replyTo,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$ChatUnreadSummaryImpl _$$ChatUnreadSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$ChatUnreadSummaryImpl(
  activityId: json['activityId'] as String,
  activityTitle: json['activityTitle'] as String,
  chatRoomId: json['chatRoomId'] as String,
  unreadCount: (json['unreadCount'] as num).toInt(),
);

Map<String, dynamic> _$$ChatUnreadSummaryImplToJson(
  _$ChatUnreadSummaryImpl instance,
) => <String, dynamic>{
  'activityId': instance.activityId,
  'activityTitle': instance.activityTitle,
  'chatRoomId': instance.chatRoomId,
  'unreadCount': instance.unreadCount,
};
