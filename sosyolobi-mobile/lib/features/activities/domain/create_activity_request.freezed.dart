// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_activity_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateActivityRequest _$CreateActivityRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateActivityRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateActivityRequest {
  String get categoryId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get eventDate => throw _privateConstructorUsedError;
  int get neededPeopleCount => throw _privateConstructorUsedError;
  double? get pricePerPerson => throw _privateConstructorUsedError;
  @SkillLevelConverter()
  SkillLevel get skillLevel => throw _privateConstructorUsedError;
  @GenderPreferenceConverter()
  GenderPreference get genderPreference => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get addressText => throw _privateConstructorUsedError;
  String? get addressDetailPrivate => throw _privateConstructorUsedError;

  /// Serializes this CreateActivityRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateActivityRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateActivityRequestCopyWith<CreateActivityRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateActivityRequestCopyWith<$Res> {
  factory $CreateActivityRequestCopyWith(
    CreateActivityRequest value,
    $Res Function(CreateActivityRequest) then,
  ) = _$CreateActivityRequestCopyWithImpl<$Res, CreateActivityRequest>;
  @useResult
  $Res call({
    String categoryId,
    String title,
    String? description,
    DateTime eventDate,
    int neededPeopleCount,
    double? pricePerPerson,
    @SkillLevelConverter() SkillLevel skillLevel,
    @GenderPreferenceConverter() GenderPreference genderPreference,
    double latitude,
    double longitude,
    String addressText,
    String? addressDetailPrivate,
  });
}

/// @nodoc
class _$CreateActivityRequestCopyWithImpl<
  $Res,
  $Val extends CreateActivityRequest
>
    implements $CreateActivityRequestCopyWith<$Res> {
  _$CreateActivityRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateActivityRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? title = null,
    Object? description = freezed,
    Object? eventDate = null,
    Object? neededPeopleCount = null,
    Object? pricePerPerson = freezed,
    Object? skillLevel = null,
    Object? genderPreference = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? addressText = null,
    Object? addressDetailPrivate = freezed,
  }) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            eventDate: null == eventDate
                ? _value.eventDate
                : eventDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            neededPeopleCount: null == neededPeopleCount
                ? _value.neededPeopleCount
                : neededPeopleCount // ignore: cast_nullable_to_non_nullable
                      as int,
            pricePerPerson: freezed == pricePerPerson
                ? _value.pricePerPerson
                : pricePerPerson // ignore: cast_nullable_to_non_nullable
                      as double?,
            skillLevel: null == skillLevel
                ? _value.skillLevel
                : skillLevel // ignore: cast_nullable_to_non_nullable
                      as SkillLevel,
            genderPreference: null == genderPreference
                ? _value.genderPreference
                : genderPreference // ignore: cast_nullable_to_non_nullable
                      as GenderPreference,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            addressText: null == addressText
                ? _value.addressText
                : addressText // ignore: cast_nullable_to_non_nullable
                      as String,
            addressDetailPrivate: freezed == addressDetailPrivate
                ? _value.addressDetailPrivate
                : addressDetailPrivate // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateActivityRequestImplCopyWith<$Res>
    implements $CreateActivityRequestCopyWith<$Res> {
  factory _$$CreateActivityRequestImplCopyWith(
    _$CreateActivityRequestImpl value,
    $Res Function(_$CreateActivityRequestImpl) then,
  ) = __$$CreateActivityRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String categoryId,
    String title,
    String? description,
    DateTime eventDate,
    int neededPeopleCount,
    double? pricePerPerson,
    @SkillLevelConverter() SkillLevel skillLevel,
    @GenderPreferenceConverter() GenderPreference genderPreference,
    double latitude,
    double longitude,
    String addressText,
    String? addressDetailPrivate,
  });
}

/// @nodoc
class __$$CreateActivityRequestImplCopyWithImpl<$Res>
    extends
        _$CreateActivityRequestCopyWithImpl<$Res, _$CreateActivityRequestImpl>
    implements _$$CreateActivityRequestImplCopyWith<$Res> {
  __$$CreateActivityRequestImplCopyWithImpl(
    _$CreateActivityRequestImpl _value,
    $Res Function(_$CreateActivityRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateActivityRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? title = null,
    Object? description = freezed,
    Object? eventDate = null,
    Object? neededPeopleCount = null,
    Object? pricePerPerson = freezed,
    Object? skillLevel = null,
    Object? genderPreference = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? addressText = null,
    Object? addressDetailPrivate = freezed,
  }) {
    return _then(
      _$CreateActivityRequestImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        eventDate: null == eventDate
            ? _value.eventDate
            : eventDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        neededPeopleCount: null == neededPeopleCount
            ? _value.neededPeopleCount
            : neededPeopleCount // ignore: cast_nullable_to_non_nullable
                  as int,
        pricePerPerson: freezed == pricePerPerson
            ? _value.pricePerPerson
            : pricePerPerson // ignore: cast_nullable_to_non_nullable
                  as double?,
        skillLevel: null == skillLevel
            ? _value.skillLevel
            : skillLevel // ignore: cast_nullable_to_non_nullable
                  as SkillLevel,
        genderPreference: null == genderPreference
            ? _value.genderPreference
            : genderPreference // ignore: cast_nullable_to_non_nullable
                  as GenderPreference,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        addressText: null == addressText
            ? _value.addressText
            : addressText // ignore: cast_nullable_to_non_nullable
                  as String,
        addressDetailPrivate: freezed == addressDetailPrivate
            ? _value.addressDetailPrivate
            : addressDetailPrivate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateActivityRequestImpl implements _CreateActivityRequest {
  const _$CreateActivityRequestImpl({
    required this.categoryId,
    required this.title,
    this.description,
    required this.eventDate,
    required this.neededPeopleCount,
    this.pricePerPerson,
    @SkillLevelConverter() this.skillLevel = SkillLevel.any,
    @GenderPreferenceConverter() this.genderPreference = GenderPreference.any,
    required this.latitude,
    required this.longitude,
    required this.addressText,
    this.addressDetailPrivate,
  });

  factory _$CreateActivityRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateActivityRequestImplFromJson(json);

  @override
  final String categoryId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime eventDate;
  @override
  final int neededPeopleCount;
  @override
  final double? pricePerPerson;
  @override
  @JsonKey()
  @SkillLevelConverter()
  final SkillLevel skillLevel;
  @override
  @JsonKey()
  @GenderPreferenceConverter()
  final GenderPreference genderPreference;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String addressText;
  @override
  final String? addressDetailPrivate;

  @override
  String toString() {
    return 'CreateActivityRequest(categoryId: $categoryId, title: $title, description: $description, eventDate: $eventDate, neededPeopleCount: $neededPeopleCount, pricePerPerson: $pricePerPerson, skillLevel: $skillLevel, genderPreference: $genderPreference, latitude: $latitude, longitude: $longitude, addressText: $addressText, addressDetailPrivate: $addressDetailPrivate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateActivityRequestImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.neededPeopleCount, neededPeopleCount) ||
                other.neededPeopleCount == neededPeopleCount) &&
            (identical(other.pricePerPerson, pricePerPerson) ||
                other.pricePerPerson == pricePerPerson) &&
            (identical(other.skillLevel, skillLevel) ||
                other.skillLevel == skillLevel) &&
            (identical(other.genderPreference, genderPreference) ||
                other.genderPreference == genderPreference) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.addressText, addressText) ||
                other.addressText == addressText) &&
            (identical(other.addressDetailPrivate, addressDetailPrivate) ||
                other.addressDetailPrivate == addressDetailPrivate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    title,
    description,
    eventDate,
    neededPeopleCount,
    pricePerPerson,
    skillLevel,
    genderPreference,
    latitude,
    longitude,
    addressText,
    addressDetailPrivate,
  );

  /// Create a copy of CreateActivityRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateActivityRequestImplCopyWith<_$CreateActivityRequestImpl>
  get copyWith =>
      __$$CreateActivityRequestImplCopyWithImpl<_$CreateActivityRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateActivityRequestImplToJson(this);
  }
}

abstract class _CreateActivityRequest implements CreateActivityRequest {
  const factory _CreateActivityRequest({
    required final String categoryId,
    required final String title,
    final String? description,
    required final DateTime eventDate,
    required final int neededPeopleCount,
    final double? pricePerPerson,
    @SkillLevelConverter() final SkillLevel skillLevel,
    @GenderPreferenceConverter() final GenderPreference genderPreference,
    required final double latitude,
    required final double longitude,
    required final String addressText,
    final String? addressDetailPrivate,
  }) = _$CreateActivityRequestImpl;

  factory _CreateActivityRequest.fromJson(Map<String, dynamic> json) =
      _$CreateActivityRequestImpl.fromJson;

  @override
  String get categoryId;
  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime get eventDate;
  @override
  int get neededPeopleCount;
  @override
  double? get pricePerPerson;
  @override
  @SkillLevelConverter()
  SkillLevel get skillLevel;
  @override
  @GenderPreferenceConverter()
  GenderPreference get genderPreference;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get addressText;
  @override
  String? get addressDetailPrivate;

  /// Create a copy of CreateActivityRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateActivityRequestImplCopyWith<_$CreateActivityRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
