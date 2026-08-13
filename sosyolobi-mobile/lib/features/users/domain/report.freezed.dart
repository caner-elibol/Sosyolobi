// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateReportRequest _$CreateReportRequestFromJson(Map<String, dynamic> json) {
  return _CreateReportRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateReportRequest {
  String? get reportedUserId => throw _privateConstructorUsedError;
  String? get reportedActivityId => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String? get details => throw _privateConstructorUsedError;

  /// Serializes this CreateReportRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateReportRequestCopyWith<CreateReportRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateReportRequestCopyWith<$Res> {
  factory $CreateReportRequestCopyWith(
    CreateReportRequest value,
    $Res Function(CreateReportRequest) then,
  ) = _$CreateReportRequestCopyWithImpl<$Res, CreateReportRequest>;
  @useResult
  $Res call({
    String? reportedUserId,
    String? reportedActivityId,
    String reason,
    String? details,
  });
}

/// @nodoc
class _$CreateReportRequestCopyWithImpl<$Res, $Val extends CreateReportRequest>
    implements $CreateReportRequestCopyWith<$Res> {
  _$CreateReportRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportedUserId = freezed,
    Object? reportedActivityId = freezed,
    Object? reason = null,
    Object? details = freezed,
  }) {
    return _then(
      _value.copyWith(
            reportedUserId: freezed == reportedUserId
                ? _value.reportedUserId
                : reportedUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
            reportedActivityId: freezed == reportedActivityId
                ? _value.reportedActivityId
                : reportedActivityId // ignore: cast_nullable_to_non_nullable
                      as String?,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            details: freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateReportRequestImplCopyWith<$Res>
    implements $CreateReportRequestCopyWith<$Res> {
  factory _$$CreateReportRequestImplCopyWith(
    _$CreateReportRequestImpl value,
    $Res Function(_$CreateReportRequestImpl) then,
  ) = __$$CreateReportRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? reportedUserId,
    String? reportedActivityId,
    String reason,
    String? details,
  });
}

/// @nodoc
class __$$CreateReportRequestImplCopyWithImpl<$Res>
    extends _$CreateReportRequestCopyWithImpl<$Res, _$CreateReportRequestImpl>
    implements _$$CreateReportRequestImplCopyWith<$Res> {
  __$$CreateReportRequestImplCopyWithImpl(
    _$CreateReportRequestImpl _value,
    $Res Function(_$CreateReportRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportedUserId = freezed,
    Object? reportedActivityId = freezed,
    Object? reason = null,
    Object? details = freezed,
  }) {
    return _then(
      _$CreateReportRequestImpl(
        reportedUserId: freezed == reportedUserId
            ? _value.reportedUserId
            : reportedUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
        reportedActivityId: freezed == reportedActivityId
            ? _value.reportedActivityId
            : reportedActivityId // ignore: cast_nullable_to_non_nullable
                  as String?,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        details: freezed == details
            ? _value.details
            : details // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateReportRequestImpl implements _CreateReportRequest {
  const _$CreateReportRequestImpl({
    this.reportedUserId,
    this.reportedActivityId,
    required this.reason,
    this.details,
  });

  factory _$CreateReportRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateReportRequestImplFromJson(json);

  @override
  final String? reportedUserId;
  @override
  final String? reportedActivityId;
  @override
  final String reason;
  @override
  final String? details;

  @override
  String toString() {
    return 'CreateReportRequest(reportedUserId: $reportedUserId, reportedActivityId: $reportedActivityId, reason: $reason, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateReportRequestImpl &&
            (identical(other.reportedUserId, reportedUserId) ||
                other.reportedUserId == reportedUserId) &&
            (identical(other.reportedActivityId, reportedActivityId) ||
                other.reportedActivityId == reportedActivityId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.details, details) || other.details == details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    reportedUserId,
    reportedActivityId,
    reason,
    details,
  );

  /// Create a copy of CreateReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateReportRequestImplCopyWith<_$CreateReportRequestImpl> get copyWith =>
      __$$CreateReportRequestImplCopyWithImpl<_$CreateReportRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateReportRequestImplToJson(this);
  }
}

abstract class _CreateReportRequest implements CreateReportRequest {
  const factory _CreateReportRequest({
    final String? reportedUserId,
    final String? reportedActivityId,
    required final String reason,
    final String? details,
  }) = _$CreateReportRequestImpl;

  factory _CreateReportRequest.fromJson(Map<String, dynamic> json) =
      _$CreateReportRequestImpl.fromJson;

  @override
  String? get reportedUserId;
  @override
  String? get reportedActivityId;
  @override
  String get reason;
  @override
  String? get details;

  /// Create a copy of CreateReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateReportRequestImplCopyWith<_$CreateReportRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
