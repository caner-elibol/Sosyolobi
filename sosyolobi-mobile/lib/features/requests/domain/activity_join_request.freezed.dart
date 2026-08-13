// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_join_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ActivityJoinRequest _$ActivityJoinRequestFromJson(Map<String, dynamic> json) {
  return _ActivityJoinRequest.fromJson(json);
}

/// @nodoc
mixin _$ActivityJoinRequest {
  String get id => throw _privateConstructorUsedError;
  String get activityId => throw _privateConstructorUsedError;
  PublicProfile get user => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @ActivityRequestStatusConverter()
  ActivityRequestStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get respondedAt => throw _privateConstructorUsedError;

  /// Serializes this ActivityJoinRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityJoinRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityJoinRequestCopyWith<ActivityJoinRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityJoinRequestCopyWith<$Res> {
  factory $ActivityJoinRequestCopyWith(
    ActivityJoinRequest value,
    $Res Function(ActivityJoinRequest) then,
  ) = _$ActivityJoinRequestCopyWithImpl<$Res, ActivityJoinRequest>;
  @useResult
  $Res call({
    String id,
    String activityId,
    PublicProfile user,
    String? message,
    @ActivityRequestStatusConverter() ActivityRequestStatus status,
    DateTime createdAt,
    DateTime? respondedAt,
  });

  $PublicProfileCopyWith<$Res> get user;
}

/// @nodoc
class _$ActivityJoinRequestCopyWithImpl<$Res, $Val extends ActivityJoinRequest>
    implements $ActivityJoinRequestCopyWith<$Res> {
  _$ActivityJoinRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityJoinRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? activityId = null,
    Object? user = null,
    Object? message = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? respondedAt = freezed,
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
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as PublicProfile,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ActivityRequestStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            respondedAt: freezed == respondedAt
                ? _value.respondedAt
                : respondedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of ActivityJoinRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicProfileCopyWith<$Res> get user {
    return $PublicProfileCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ActivityJoinRequestImplCopyWith<$Res>
    implements $ActivityJoinRequestCopyWith<$Res> {
  factory _$$ActivityJoinRequestImplCopyWith(
    _$ActivityJoinRequestImpl value,
    $Res Function(_$ActivityJoinRequestImpl) then,
  ) = __$$ActivityJoinRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String activityId,
    PublicProfile user,
    String? message,
    @ActivityRequestStatusConverter() ActivityRequestStatus status,
    DateTime createdAt,
    DateTime? respondedAt,
  });

  @override
  $PublicProfileCopyWith<$Res> get user;
}

/// @nodoc
class __$$ActivityJoinRequestImplCopyWithImpl<$Res>
    extends _$ActivityJoinRequestCopyWithImpl<$Res, _$ActivityJoinRequestImpl>
    implements _$$ActivityJoinRequestImplCopyWith<$Res> {
  __$$ActivityJoinRequestImplCopyWithImpl(
    _$ActivityJoinRequestImpl _value,
    $Res Function(_$ActivityJoinRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityJoinRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? activityId = null,
    Object? user = null,
    Object? message = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? respondedAt = freezed,
  }) {
    return _then(
      _$ActivityJoinRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        activityId: null == activityId
            ? _value.activityId
            : activityId // ignore: cast_nullable_to_non_nullable
                  as String,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as PublicProfile,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ActivityRequestStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        respondedAt: freezed == respondedAt
            ? _value.respondedAt
            : respondedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityJoinRequestImpl implements _ActivityJoinRequest {
  const _$ActivityJoinRequestImpl({
    required this.id,
    required this.activityId,
    required this.user,
    this.message,
    @ActivityRequestStatusConverter() required this.status,
    required this.createdAt,
    this.respondedAt,
  });

  factory _$ActivityJoinRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityJoinRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String activityId;
  @override
  final PublicProfile user;
  @override
  final String? message;
  @override
  @ActivityRequestStatusConverter()
  final ActivityRequestStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? respondedAt;

  @override
  String toString() {
    return 'ActivityJoinRequest(id: $id, activityId: $activityId, user: $user, message: $message, status: $status, createdAt: $createdAt, respondedAt: $respondedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityJoinRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.activityId, activityId) ||
                other.activityId == activityId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    activityId,
    user,
    message,
    status,
    createdAt,
    respondedAt,
  );

  /// Create a copy of ActivityJoinRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityJoinRequestImplCopyWith<_$ActivityJoinRequestImpl> get copyWith =>
      __$$ActivityJoinRequestImplCopyWithImpl<_$ActivityJoinRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityJoinRequestImplToJson(this);
  }
}

abstract class _ActivityJoinRequest implements ActivityJoinRequest {
  const factory _ActivityJoinRequest({
    required final String id,
    required final String activityId,
    required final PublicProfile user,
    final String? message,
    @ActivityRequestStatusConverter()
    required final ActivityRequestStatus status,
    required final DateTime createdAt,
    final DateTime? respondedAt,
  }) = _$ActivityJoinRequestImpl;

  factory _ActivityJoinRequest.fromJson(Map<String, dynamic> json) =
      _$ActivityJoinRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get activityId;
  @override
  PublicProfile get user;
  @override
  String? get message;
  @override
  @ActivityRequestStatusConverter()
  ActivityRequestStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get respondedAt;

  /// Create a copy of ActivityJoinRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityJoinRequestImplCopyWith<_$ActivityJoinRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
