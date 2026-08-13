// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return _ChatRoom.fromJson(json);
}

/// @nodoc
mixin _$ChatRoom {
  String get id => throw _privateConstructorUsedError;
  String get activityId => throw _privateConstructorUsedError;
  @ChatRoomStatusConverter()
  ChatRoomStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get closedAt => throw _privateConstructorUsedError;

  /// Serializes this ChatRoom to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatRoomCopyWith<ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomCopyWith<$Res> {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) then) =
      _$ChatRoomCopyWithImpl<$Res, ChatRoom>;
  @useResult
  $Res call({
    String id,
    String activityId,
    @ChatRoomStatusConverter() ChatRoomStatus status,
    DateTime createdAt,
    DateTime? closedAt,
  });
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res, $Val extends ChatRoom>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? activityId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? closedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            activityId: null == activityId
                ? _value.activityId
                : activityId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ChatRoomStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            closedAt: freezed == closedAt
                ? _value.closedAt
                : closedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatRoomImplCopyWith<$Res>
    implements $ChatRoomCopyWith<$Res> {
  factory _$$ChatRoomImplCopyWith(
    _$ChatRoomImpl value,
    $Res Function(_$ChatRoomImpl) then,
  ) = __$$ChatRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String activityId,
    @ChatRoomStatusConverter() ChatRoomStatus status,
    DateTime createdAt,
    DateTime? closedAt,
  });
}

/// @nodoc
class __$$ChatRoomImplCopyWithImpl<$Res>
    extends _$ChatRoomCopyWithImpl<$Res, _$ChatRoomImpl>
    implements _$$ChatRoomImplCopyWith<$Res> {
  __$$ChatRoomImplCopyWithImpl(
    _$ChatRoomImpl _value,
    $Res Function(_$ChatRoomImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? activityId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? closedAt = freezed,
  }) {
    return _then(
      _$ChatRoomImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        activityId: null == activityId
            ? _value.activityId
            : activityId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ChatRoomStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        closedAt: freezed == closedAt
            ? _value.closedAt
            : closedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomImpl implements _ChatRoom {
  const _$ChatRoomImpl({
    required this.id,
    required this.activityId,
    @ChatRoomStatusConverter() required this.status,
    required this.createdAt,
    this.closedAt,
  });

  factory _$ChatRoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomImplFromJson(json);

  @override
  final String id;
  @override
  final String activityId;
  @override
  @ChatRoomStatusConverter()
  final ChatRoomStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? closedAt;

  @override
  String toString() {
    return 'ChatRoom(id: $id, activityId: $activityId, status: $status, createdAt: $createdAt, closedAt: $closedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.activityId, activityId) ||
                other.activityId == activityId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.closedAt, closedAt) ||
                other.closedAt == closedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, activityId, status, createdAt, closedAt);

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      __$$ChatRoomImplCopyWithImpl<_$ChatRoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomImplToJson(this);
  }
}

abstract class _ChatRoom implements ChatRoom {
  const factory _ChatRoom({
    required final String id,
    required final String activityId,
    @ChatRoomStatusConverter() required final ChatRoomStatus status,
    required final DateTime createdAt,
    final DateTime? closedAt,
  }) = _$ChatRoomImpl;

  factory _ChatRoom.fromJson(Map<String, dynamic> json) =
      _$ChatRoomImpl.fromJson;

  @override
  String get id;
  @override
  String get activityId;
  @override
  @ChatRoomStatusConverter()
  ChatRoomStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get closedAt;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessageReplyPreview _$ChatMessageReplyPreviewFromJson(
  Map<String, dynamic> json,
) {
  return _ChatMessageReplyPreview.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageReplyPreview {
  String get id => throw _privateConstructorUsedError;
  String get senderDisplayName => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  /// Serializes this ChatMessageReplyPreview to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessageReplyPreview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageReplyPreviewCopyWith<ChatMessageReplyPreview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageReplyPreviewCopyWith<$Res> {
  factory $ChatMessageReplyPreviewCopyWith(
    ChatMessageReplyPreview value,
    $Res Function(ChatMessageReplyPreview) then,
  ) = _$ChatMessageReplyPreviewCopyWithImpl<$Res, ChatMessageReplyPreview>;
  @useResult
  $Res call({String id, String senderDisplayName, String content});
}

/// @nodoc
class _$ChatMessageReplyPreviewCopyWithImpl<
  $Res,
  $Val extends ChatMessageReplyPreview
>
    implements $ChatMessageReplyPreviewCopyWith<$Res> {
  _$ChatMessageReplyPreviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessageReplyPreview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderDisplayName = null,
    Object? content = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            senderDisplayName: null == senderDisplayName
                ? _value.senderDisplayName
                : senderDisplayName // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatMessageReplyPreviewImplCopyWith<$Res>
    implements $ChatMessageReplyPreviewCopyWith<$Res> {
  factory _$$ChatMessageReplyPreviewImplCopyWith(
    _$ChatMessageReplyPreviewImpl value,
    $Res Function(_$ChatMessageReplyPreviewImpl) then,
  ) = __$$ChatMessageReplyPreviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String senderDisplayName, String content});
}

/// @nodoc
class __$$ChatMessageReplyPreviewImplCopyWithImpl<$Res>
    extends
        _$ChatMessageReplyPreviewCopyWithImpl<
          $Res,
          _$ChatMessageReplyPreviewImpl
        >
    implements _$$ChatMessageReplyPreviewImplCopyWith<$Res> {
  __$$ChatMessageReplyPreviewImplCopyWithImpl(
    _$ChatMessageReplyPreviewImpl _value,
    $Res Function(_$ChatMessageReplyPreviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessageReplyPreview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderDisplayName = null,
    Object? content = null,
  }) {
    return _then(
      _$ChatMessageReplyPreviewImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        senderDisplayName: null == senderDisplayName
            ? _value.senderDisplayName
            : senderDisplayName // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageReplyPreviewImpl implements _ChatMessageReplyPreview {
  const _$ChatMessageReplyPreviewImpl({
    required this.id,
    required this.senderDisplayName,
    required this.content,
  });

  factory _$ChatMessageReplyPreviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageReplyPreviewImplFromJson(json);

  @override
  final String id;
  @override
  final String senderDisplayName;
  @override
  final String content;

  @override
  String toString() {
    return 'ChatMessageReplyPreview(id: $id, senderDisplayName: $senderDisplayName, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageReplyPreviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderDisplayName, senderDisplayName) ||
                other.senderDisplayName == senderDisplayName) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, senderDisplayName, content);

  /// Create a copy of ChatMessageReplyPreview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageReplyPreviewImplCopyWith<_$ChatMessageReplyPreviewImpl>
  get copyWith =>
      __$$ChatMessageReplyPreviewImplCopyWithImpl<
        _$ChatMessageReplyPreviewImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageReplyPreviewImplToJson(this);
  }
}

abstract class _ChatMessageReplyPreview implements ChatMessageReplyPreview {
  const factory _ChatMessageReplyPreview({
    required final String id,
    required final String senderDisplayName,
    required final String content,
  }) = _$ChatMessageReplyPreviewImpl;

  factory _ChatMessageReplyPreview.fromJson(Map<String, dynamic> json) =
      _$ChatMessageReplyPreviewImpl.fromJson;

  @override
  String get id;
  @override
  String get senderDisplayName;
  @override
  String get content;

  /// Create a copy of ChatMessageReplyPreview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageReplyPreviewImplCopyWith<_$ChatMessageReplyPreviewImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get id => throw _privateConstructorUsedError;
  String get chatRoomId => throw _privateConstructorUsedError;
  String get senderUserId => throw _privateConstructorUsedError;
  String get senderDisplayName => throw _privateConstructorUsedError;
  String? get senderAvatarUrl => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  ChatMessageReplyPreview? get replyTo => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
    ChatMessage value,
    $Res Function(ChatMessage) then,
  ) = _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call({
    String id,
    String chatRoomId,
    String senderUserId,
    String senderDisplayName,
    String? senderAvatarUrl,
    String content,
    ChatMessageReplyPreview? replyTo,
    DateTime createdAt,
  });

  $ChatMessageReplyPreviewCopyWith<$Res>? get replyTo;
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatRoomId = null,
    Object? senderUserId = null,
    Object? senderDisplayName = null,
    Object? senderAvatarUrl = freezed,
    Object? content = null,
    Object? replyTo = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            chatRoomId: null == chatRoomId
                ? _value.chatRoomId
                : chatRoomId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderUserId: null == senderUserId
                ? _value.senderUserId
                : senderUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderDisplayName: null == senderDisplayName
                ? _value.senderDisplayName
                : senderDisplayName // ignore: cast_nullable_to_non_nullable
                      as String,
            senderAvatarUrl: freezed == senderAvatarUrl
                ? _value.senderAvatarUrl
                : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            replyTo: freezed == replyTo
                ? _value.replyTo
                : replyTo // ignore: cast_nullable_to_non_nullable
                      as ChatMessageReplyPreview?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageReplyPreviewCopyWith<$Res>? get replyTo {
    if (_value.replyTo == null) {
      return null;
    }

    return $ChatMessageReplyPreviewCopyWith<$Res>(_value.replyTo!, (value) {
      return _then(_value.copyWith(replyTo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
    _$ChatMessageImpl value,
    $Res Function(_$ChatMessageImpl) then,
  ) = __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String chatRoomId,
    String senderUserId,
    String senderDisplayName,
    String? senderAvatarUrl,
    String content,
    ChatMessageReplyPreview? replyTo,
    DateTime createdAt,
  });

  @override
  $ChatMessageReplyPreviewCopyWith<$Res>? get replyTo;
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
    _$ChatMessageImpl _value,
    $Res Function(_$ChatMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatRoomId = null,
    Object? senderUserId = null,
    Object? senderDisplayName = null,
    Object? senderAvatarUrl = freezed,
    Object? content = null,
    Object? replyTo = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$ChatMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        chatRoomId: null == chatRoomId
            ? _value.chatRoomId
            : chatRoomId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderUserId: null == senderUserId
            ? _value.senderUserId
            : senderUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderDisplayName: null == senderDisplayName
            ? _value.senderDisplayName
            : senderDisplayName // ignore: cast_nullable_to_non_nullable
                  as String,
        senderAvatarUrl: freezed == senderAvatarUrl
            ? _value.senderAvatarUrl
            : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        replyTo: freezed == replyTo
            ? _value.replyTo
            : replyTo // ignore: cast_nullable_to_non_nullable
                  as ChatMessageReplyPreview?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl implements _ChatMessage {
  const _$ChatMessageImpl({
    required this.id,
    required this.chatRoomId,
    required this.senderUserId,
    required this.senderDisplayName,
    this.senderAvatarUrl,
    required this.content,
    this.replyTo,
    required this.createdAt,
  });

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String chatRoomId;
  @override
  final String senderUserId;
  @override
  final String senderDisplayName;
  @override
  final String? senderAvatarUrl;
  @override
  final String content;
  @override
  final ChatMessageReplyPreview? replyTo;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ChatMessage(id: $id, chatRoomId: $chatRoomId, senderUserId: $senderUserId, senderDisplayName: $senderDisplayName, senderAvatarUrl: $senderAvatarUrl, content: $content, replyTo: $replyTo, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.senderUserId, senderUserId) ||
                other.senderUserId == senderUserId) &&
            (identical(other.senderDisplayName, senderDisplayName) ||
                other.senderDisplayName == senderDisplayName) &&
            (identical(other.senderAvatarUrl, senderAvatarUrl) ||
                other.senderAvatarUrl == senderAvatarUrl) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    chatRoomId,
    senderUserId,
    senderDisplayName,
    senderAvatarUrl,
    content,
    replyTo,
    createdAt,
  );

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(this);
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage({
    required final String id,
    required final String chatRoomId,
    required final String senderUserId,
    required final String senderDisplayName,
    final String? senderAvatarUrl,
    required final String content,
    final ChatMessageReplyPreview? replyTo,
    required final DateTime createdAt,
  }) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get chatRoomId;
  @override
  String get senderUserId;
  @override
  String get senderDisplayName;
  @override
  String? get senderAvatarUrl;
  @override
  String get content;
  @override
  ChatMessageReplyPreview? get replyTo;
  @override
  DateTime get createdAt;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatUnreadSummary _$ChatUnreadSummaryFromJson(Map<String, dynamic> json) {
  return _ChatUnreadSummary.fromJson(json);
}

/// @nodoc
mixin _$ChatUnreadSummary {
  String get activityId => throw _privateConstructorUsedError;
  String get activityTitle => throw _privateConstructorUsedError;
  String get chatRoomId => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;

  /// Serializes this ChatUnreadSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatUnreadSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatUnreadSummaryCopyWith<ChatUnreadSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatUnreadSummaryCopyWith<$Res> {
  factory $ChatUnreadSummaryCopyWith(
    ChatUnreadSummary value,
    $Res Function(ChatUnreadSummary) then,
  ) = _$ChatUnreadSummaryCopyWithImpl<$Res, ChatUnreadSummary>;
  @useResult
  $Res call({
    String activityId,
    String activityTitle,
    String chatRoomId,
    int unreadCount,
  });
}

/// @nodoc
class _$ChatUnreadSummaryCopyWithImpl<$Res, $Val extends ChatUnreadSummary>
    implements $ChatUnreadSummaryCopyWith<$Res> {
  _$ChatUnreadSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatUnreadSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityId = null,
    Object? activityTitle = null,
    Object? chatRoomId = null,
    Object? unreadCount = null,
  }) {
    return _then(
      _value.copyWith(
            activityId: null == activityId
                ? _value.activityId
                : activityId // ignore: cast_nullable_to_non_nullable
                      as String,
            activityTitle: null == activityTitle
                ? _value.activityTitle
                : activityTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            chatRoomId: null == chatRoomId
                ? _value.chatRoomId
                : chatRoomId // ignore: cast_nullable_to_non_nullable
                      as String,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatUnreadSummaryImplCopyWith<$Res>
    implements $ChatUnreadSummaryCopyWith<$Res> {
  factory _$$ChatUnreadSummaryImplCopyWith(
    _$ChatUnreadSummaryImpl value,
    $Res Function(_$ChatUnreadSummaryImpl) then,
  ) = __$$ChatUnreadSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String activityId,
    String activityTitle,
    String chatRoomId,
    int unreadCount,
  });
}

/// @nodoc
class __$$ChatUnreadSummaryImplCopyWithImpl<$Res>
    extends _$ChatUnreadSummaryCopyWithImpl<$Res, _$ChatUnreadSummaryImpl>
    implements _$$ChatUnreadSummaryImplCopyWith<$Res> {
  __$$ChatUnreadSummaryImplCopyWithImpl(
    _$ChatUnreadSummaryImpl _value,
    $Res Function(_$ChatUnreadSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatUnreadSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityId = null,
    Object? activityTitle = null,
    Object? chatRoomId = null,
    Object? unreadCount = null,
  }) {
    return _then(
      _$ChatUnreadSummaryImpl(
        activityId: null == activityId
            ? _value.activityId
            : activityId // ignore: cast_nullable_to_non_nullable
                  as String,
        activityTitle: null == activityTitle
            ? _value.activityTitle
            : activityTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        chatRoomId: null == chatRoomId
            ? _value.chatRoomId
            : chatRoomId // ignore: cast_nullable_to_non_nullable
                  as String,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatUnreadSummaryImpl implements _ChatUnreadSummary {
  const _$ChatUnreadSummaryImpl({
    required this.activityId,
    required this.activityTitle,
    required this.chatRoomId,
    required this.unreadCount,
  });

  factory _$ChatUnreadSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatUnreadSummaryImplFromJson(json);

  @override
  final String activityId;
  @override
  final String activityTitle;
  @override
  final String chatRoomId;
  @override
  final int unreadCount;

  @override
  String toString() {
    return 'ChatUnreadSummary(activityId: $activityId, activityTitle: $activityTitle, chatRoomId: $chatRoomId, unreadCount: $unreadCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatUnreadSummaryImpl &&
            (identical(other.activityId, activityId) ||
                other.activityId == activityId) &&
            (identical(other.activityTitle, activityTitle) ||
                other.activityTitle == activityTitle) &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    activityId,
    activityTitle,
    chatRoomId,
    unreadCount,
  );

  /// Create a copy of ChatUnreadSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatUnreadSummaryImplCopyWith<_$ChatUnreadSummaryImpl> get copyWith =>
      __$$ChatUnreadSummaryImplCopyWithImpl<_$ChatUnreadSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatUnreadSummaryImplToJson(this);
  }
}

abstract class _ChatUnreadSummary implements ChatUnreadSummary {
  const factory _ChatUnreadSummary({
    required final String activityId,
    required final String activityTitle,
    required final String chatRoomId,
    required final int unreadCount,
  }) = _$ChatUnreadSummaryImpl;

  factory _ChatUnreadSummary.fromJson(Map<String, dynamic> json) =
      _$ChatUnreadSummaryImpl.fromJson;

  @override
  String get activityId;
  @override
  String get activityTitle;
  @override
  String get chatRoomId;
  @override
  int get unreadCount;

  /// Create a copy of ChatUnreadSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatUnreadSummaryImplCopyWith<_$ChatUnreadSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
