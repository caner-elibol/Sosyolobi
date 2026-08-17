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

ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) {
  return _ReportResponse.fromJson(json);
}

/// @nodoc
mixin _$ReportResponse {
  String get id => throw _privateConstructorUsedError;
  String get reporterUserId => throw _privateConstructorUsedError;
  String? get reportedUserId => throw _privateConstructorUsedError;
  String? get reportedActivityId => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String? get details => throw _privateConstructorUsedError;
  @ReportStatusConverter()
  ReportStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;

  /// Serializes this ReportResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportResponseCopyWith<ReportResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportResponseCopyWith<$Res> {
  factory $ReportResponseCopyWith(
    ReportResponse value,
    $Res Function(ReportResponse) then,
  ) = _$ReportResponseCopyWithImpl<$Res, ReportResponse>;
  @useResult
  $Res call({
    String id,
    String reporterUserId,
    String? reportedUserId,
    String? reportedActivityId,
    String reason,
    String? details,
    @ReportStatusConverter() ReportStatus status,
    DateTime createdAt,
    DateTime? resolvedAt,
  });
}

/// @nodoc
class _$ReportResponseCopyWithImpl<$Res, $Val extends ReportResponse>
    implements $ReportResponseCopyWith<$Res> {
  _$ReportResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reporterUserId = null,
    Object? reportedUserId = freezed,
    Object? reportedActivityId = freezed,
    Object? reason = null,
    Object? details = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? resolvedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            reporterUserId: null == reporterUserId
                ? _value.reporterUserId
                : reporterUserId // ignore: cast_nullable_to_non_nullable
                      as String,
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
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ReportStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            resolvedAt: freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReportResponseImplCopyWith<$Res>
    implements $ReportResponseCopyWith<$Res> {
  factory _$$ReportResponseImplCopyWith(
    _$ReportResponseImpl value,
    $Res Function(_$ReportResponseImpl) then,
  ) = __$$ReportResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String reporterUserId,
    String? reportedUserId,
    String? reportedActivityId,
    String reason,
    String? details,
    @ReportStatusConverter() ReportStatus status,
    DateTime createdAt,
    DateTime? resolvedAt,
  });
}

/// @nodoc
class __$$ReportResponseImplCopyWithImpl<$Res>
    extends _$ReportResponseCopyWithImpl<$Res, _$ReportResponseImpl>
    implements _$$ReportResponseImplCopyWith<$Res> {
  __$$ReportResponseImplCopyWithImpl(
    _$ReportResponseImpl _value,
    $Res Function(_$ReportResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reporterUserId = null,
    Object? reportedUserId = freezed,
    Object? reportedActivityId = freezed,
    Object? reason = null,
    Object? details = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? resolvedAt = freezed,
  }) {
    return _then(
      _$ReportResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        reporterUserId: null == reporterUserId
            ? _value.reporterUserId
            : reporterUserId // ignore: cast_nullable_to_non_nullable
                  as String,
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
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ReportStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        resolvedAt: freezed == resolvedAt
            ? _value.resolvedAt
            : resolvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportResponseImpl implements _ReportResponse {
  const _$ReportResponseImpl({
    required this.id,
    required this.reporterUserId,
    this.reportedUserId,
    this.reportedActivityId,
    required this.reason,
    this.details,
    @ReportStatusConverter() required this.status,
    required this.createdAt,
    this.resolvedAt,
  });

  factory _$ReportResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String reporterUserId;
  @override
  final String? reportedUserId;
  @override
  final String? reportedActivityId;
  @override
  final String reason;
  @override
  final String? details;
  @override
  @ReportStatusConverter()
  final ReportStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? resolvedAt;

  @override
  String toString() {
    return 'ReportResponse(id: $id, reporterUserId: $reporterUserId, reportedUserId: $reportedUserId, reportedActivityId: $reportedActivityId, reason: $reason, details: $details, status: $status, createdAt: $createdAt, resolvedAt: $resolvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.reporterUserId, reporterUserId) ||
                other.reporterUserId == reporterUserId) &&
            (identical(other.reportedUserId, reportedUserId) ||
                other.reportedUserId == reportedUserId) &&
            (identical(other.reportedActivityId, reportedActivityId) ||
                other.reportedActivityId == reportedActivityId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    reporterUserId,
    reportedUserId,
    reportedActivityId,
    reason,
    details,
    status,
    createdAt,
    resolvedAt,
  );

  /// Create a copy of ReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportResponseImplCopyWith<_$ReportResponseImpl> get copyWith =>
      __$$ReportResponseImplCopyWithImpl<_$ReportResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportResponseImplToJson(this);
  }
}

abstract class _ReportResponse implements ReportResponse {
  const factory _ReportResponse({
    required final String id,
    required final String reporterUserId,
    final String? reportedUserId,
    final String? reportedActivityId,
    required final String reason,
    final String? details,
    @ReportStatusConverter() required final ReportStatus status,
    required final DateTime createdAt,
    final DateTime? resolvedAt,
  }) = _$ReportResponseImpl;

  factory _ReportResponse.fromJson(Map<String, dynamic> json) =
      _$ReportResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get reporterUserId;
  @override
  String? get reportedUserId;
  @override
  String? get reportedActivityId;
  @override
  String get reason;
  @override
  String? get details;
  @override
  @ReportStatusConverter()
  ReportStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get resolvedAt;

  /// Create a copy of ReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportResponseImplCopyWith<_$ReportResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
