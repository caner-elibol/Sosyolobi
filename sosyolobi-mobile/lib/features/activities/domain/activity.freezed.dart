// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return _Activity.fromJson(json);
}

/// @nodoc
mixin _$Activity {
  String get id => throw _privateConstructorUsedError;
  String get createdByUserId => throw _privateConstructorUsedError;
  String get createdByDisplayName => throw _privateConstructorUsedError;
  String? get createdByAvatarUrl => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  String? get categoryImageUrl => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get eventDate => throw _privateConstructorUsedError;
  int get neededPeopleCount => throw _privateConstructorUsedError;
  int get currentPeopleCount => throw _privateConstructorUsedError;
  double? get pricePerPerson => throw _privateConstructorUsedError;
  @SkillLevelConverter()
  SkillLevel get skillLevel => throw _privateConstructorUsedError;
  @GenderPreferenceConverter()
  GenderPreference get genderPreference => throw _privateConstructorUsedError;
  @ActivityStatusConverter()
  ActivityStatus get status => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get addressText => throw _privateConstructorUsedError;
  double? get distanceMeters => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Activity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityCopyWith<Activity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityCopyWith<$Res> {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) then) =
      _$ActivityCopyWithImpl<$Res, Activity>;
  @useResult
  $Res call({
    String id,
    String createdByUserId,
    String createdByDisplayName,
    String? createdByAvatarUrl,
    String categoryId,
    String categoryName,
    String? categoryImageUrl,
    String title,
    String? description,
    DateTime eventDate,
    int neededPeopleCount,
    int currentPeopleCount,
    double? pricePerPerson,
    @SkillLevelConverter() SkillLevel skillLevel,
    @GenderPreferenceConverter() GenderPreference genderPreference,
    @ActivityStatusConverter() ActivityStatus status,
    double latitude,
    double longitude,
    String addressText,
    double? distanceMeters,
    DateTime createdAt,
  });
}

/// @nodoc
class _$ActivityCopyWithImpl<$Res, $Val extends Activity>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdByUserId = null,
    Object? createdByDisplayName = null,
    Object? createdByAvatarUrl = freezed,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? categoryImageUrl = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? eventDate = null,
    Object? neededPeopleCount = null,
    Object? currentPeopleCount = null,
    Object? pricePerPerson = freezed,
    Object? skillLevel = null,
    Object? genderPreference = null,
    Object? status = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? addressText = null,
    Object? distanceMeters = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            createdByUserId: null == createdByUserId
                ? _value.createdByUserId
                : createdByUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            createdByDisplayName: null == createdByDisplayName
                ? _value.createdByDisplayName
                : createdByDisplayName // ignore: cast_nullable_to_non_nullable
                      as String,
            createdByAvatarUrl: freezed == createdByAvatarUrl
                ? _value.createdByAvatarUrl
                : createdByAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryImageUrl: freezed == categoryImageUrl
                ? _value.categoryImageUrl
                : categoryImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            currentPeopleCount: null == currentPeopleCount
                ? _value.currentPeopleCount
                : currentPeopleCount // ignore: cast_nullable_to_non_nullable
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
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ActivityStatus,
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
            distanceMeters: freezed == distanceMeters
                ? _value.distanceMeters
                : distanceMeters // ignore: cast_nullable_to_non_nullable
                      as double?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActivityImplCopyWith<$Res>
    implements $ActivityCopyWith<$Res> {
  factory _$$ActivityImplCopyWith(
    _$ActivityImpl value,
    $Res Function(_$ActivityImpl) then,
  ) = __$$ActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String createdByUserId,
    String createdByDisplayName,
    String? createdByAvatarUrl,
    String categoryId,
    String categoryName,
    String? categoryImageUrl,
    String title,
    String? description,
    DateTime eventDate,
    int neededPeopleCount,
    int currentPeopleCount,
    double? pricePerPerson,
    @SkillLevelConverter() SkillLevel skillLevel,
    @GenderPreferenceConverter() GenderPreference genderPreference,
    @ActivityStatusConverter() ActivityStatus status,
    double latitude,
    double longitude,
    String addressText,
    double? distanceMeters,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$ActivityImplCopyWithImpl<$Res>
    extends _$ActivityCopyWithImpl<$Res, _$ActivityImpl>
    implements _$$ActivityImplCopyWith<$Res> {
  __$$ActivityImplCopyWithImpl(
    _$ActivityImpl _value,
    $Res Function(_$ActivityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdByUserId = null,
    Object? createdByDisplayName = null,
    Object? createdByAvatarUrl = freezed,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? categoryImageUrl = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? eventDate = null,
    Object? neededPeopleCount = null,
    Object? currentPeopleCount = null,
    Object? pricePerPerson = freezed,
    Object? skillLevel = null,
    Object? genderPreference = null,
    Object? status = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? addressText = null,
    Object? distanceMeters = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$ActivityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        createdByUserId: null == createdByUserId
            ? _value.createdByUserId
            : createdByUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        createdByDisplayName: null == createdByDisplayName
            ? _value.createdByDisplayName
            : createdByDisplayName // ignore: cast_nullable_to_non_nullable
                  as String,
        createdByAvatarUrl: freezed == createdByAvatarUrl
            ? _value.createdByAvatarUrl
            : createdByAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryImageUrl: freezed == categoryImageUrl
            ? _value.categoryImageUrl
            : categoryImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        currentPeopleCount: null == currentPeopleCount
            ? _value.currentPeopleCount
            : currentPeopleCount // ignore: cast_nullable_to_non_nullable
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
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ActivityStatus,
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
        distanceMeters: freezed == distanceMeters
            ? _value.distanceMeters
            : distanceMeters // ignore: cast_nullable_to_non_nullable
                  as double?,
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
class _$ActivityImpl implements _Activity {
  const _$ActivityImpl({
    required this.id,
    required this.createdByUserId,
    required this.createdByDisplayName,
    this.createdByAvatarUrl,
    required this.categoryId,
    required this.categoryName,
    this.categoryImageUrl,
    required this.title,
    this.description,
    required this.eventDate,
    required this.neededPeopleCount,
    required this.currentPeopleCount,
    this.pricePerPerson,
    @SkillLevelConverter() required this.skillLevel,
    @GenderPreferenceConverter() required this.genderPreference,
    @ActivityStatusConverter() required this.status,
    required this.latitude,
    required this.longitude,
    required this.addressText,
    this.distanceMeters,
    required this.createdAt,
  });

  factory _$ActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityImplFromJson(json);

  @override
  final String id;
  @override
  final String createdByUserId;
  @override
  final String createdByDisplayName;
  @override
  final String? createdByAvatarUrl;
  @override
  final String categoryId;
  @override
  final String categoryName;
  @override
  final String? categoryImageUrl;
  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime eventDate;
  @override
  final int neededPeopleCount;
  @override
  final int currentPeopleCount;
  @override
  final double? pricePerPerson;
  @override
  @SkillLevelConverter()
  final SkillLevel skillLevel;
  @override
  @GenderPreferenceConverter()
  final GenderPreference genderPreference;
  @override
  @ActivityStatusConverter()
  final ActivityStatus status;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String addressText;
  @override
  final double? distanceMeters;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Activity(id: $id, createdByUserId: $createdByUserId, createdByDisplayName: $createdByDisplayName, createdByAvatarUrl: $createdByAvatarUrl, categoryId: $categoryId, categoryName: $categoryName, categoryImageUrl: $categoryImageUrl, title: $title, description: $description, eventDate: $eventDate, neededPeopleCount: $neededPeopleCount, currentPeopleCount: $currentPeopleCount, pricePerPerson: $pricePerPerson, skillLevel: $skillLevel, genderPreference: $genderPreference, status: $status, latitude: $latitude, longitude: $longitude, addressText: $addressText, distanceMeters: $distanceMeters, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdByUserId, createdByUserId) ||
                other.createdByUserId == createdByUserId) &&
            (identical(other.createdByDisplayName, createdByDisplayName) ||
                other.createdByDisplayName == createdByDisplayName) &&
            (identical(other.createdByAvatarUrl, createdByAvatarUrl) ||
                other.createdByAvatarUrl == createdByAvatarUrl) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryImageUrl, categoryImageUrl) ||
                other.categoryImageUrl == categoryImageUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.neededPeopleCount, neededPeopleCount) ||
                other.neededPeopleCount == neededPeopleCount) &&
            (identical(other.currentPeopleCount, currentPeopleCount) ||
                other.currentPeopleCount == currentPeopleCount) &&
            (identical(other.pricePerPerson, pricePerPerson) ||
                other.pricePerPerson == pricePerPerson) &&
            (identical(other.skillLevel, skillLevel) ||
                other.skillLevel == skillLevel) &&
            (identical(other.genderPreference, genderPreference) ||
                other.genderPreference == genderPreference) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.addressText, addressText) ||
                other.addressText == addressText) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    createdByUserId,
    createdByDisplayName,
    createdByAvatarUrl,
    categoryId,
    categoryName,
    categoryImageUrl,
    title,
    description,
    eventDate,
    neededPeopleCount,
    currentPeopleCount,
    pricePerPerson,
    skillLevel,
    genderPreference,
    status,
    latitude,
    longitude,
    addressText,
    distanceMeters,
    createdAt,
  ]);

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      __$$ActivityImplCopyWithImpl<_$ActivityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityImplToJson(this);
  }
}

abstract class _Activity implements Activity {
  const factory _Activity({
    required final String id,
    required final String createdByUserId,
    required final String createdByDisplayName,
    final String? createdByAvatarUrl,
    required final String categoryId,
    required final String categoryName,
    final String? categoryImageUrl,
    required final String title,
    final String? description,
    required final DateTime eventDate,
    required final int neededPeopleCount,
    required final int currentPeopleCount,
    final double? pricePerPerson,
    @SkillLevelConverter() required final SkillLevel skillLevel,
    @GenderPreferenceConverter()
    required final GenderPreference genderPreference,
    @ActivityStatusConverter() required final ActivityStatus status,
    required final double latitude,
    required final double longitude,
    required final String addressText,
    final double? distanceMeters,
    required final DateTime createdAt,
  }) = _$ActivityImpl;

  factory _Activity.fromJson(Map<String, dynamic> json) =
      _$ActivityImpl.fromJson;

  @override
  String get id;
  @override
  String get createdByUserId;
  @override
  String get createdByDisplayName;
  @override
  String? get createdByAvatarUrl;
  @override
  String get categoryId;
  @override
  String get categoryName;
  @override
  String? get categoryImageUrl;
  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime get eventDate;
  @override
  int get neededPeopleCount;
  @override
  int get currentPeopleCount;
  @override
  double? get pricePerPerson;
  @override
  @SkillLevelConverter()
  SkillLevel get skillLevel;
  @override
  @GenderPreferenceConverter()
  GenderPreference get genderPreference;
  @override
  @ActivityStatusConverter()
  ActivityStatus get status;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get addressText;
  @override
  double? get distanceMeters;
  @override
  DateTime get createdAt;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActivityDetail _$ActivityDetailFromJson(Map<String, dynamic> json) {
  return _ActivityDetail.fromJson(json);
}

/// @nodoc
mixin _$ActivityDetail {
  String get id => throw _privateConstructorUsedError;
  String get createdByUserId => throw _privateConstructorUsedError;
  String get createdByDisplayName => throw _privateConstructorUsedError;
  String? get createdByAvatarUrl => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  String? get categoryImageUrl => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get eventDate => throw _privateConstructorUsedError;
  int get neededPeopleCount => throw _privateConstructorUsedError;
  int get currentPeopleCount => throw _privateConstructorUsedError;
  double? get pricePerPerson => throw _privateConstructorUsedError;
  @SkillLevelConverter()
  SkillLevel get skillLevel => throw _privateConstructorUsedError;
  @GenderPreferenceConverter()
  GenderPreference get genderPreference => throw _privateConstructorUsedError;
  @ActivityStatusConverter()
  ActivityStatus get status => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get addressText => throw _privateConstructorUsedError;
  double? get distanceMeters => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get addressDetailPrivate => throw _privateConstructorUsedError;
  List<PublicProfile> get participants => throw _privateConstructorUsedError;

  /// Serializes this ActivityDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityDetailCopyWith<ActivityDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityDetailCopyWith<$Res> {
  factory $ActivityDetailCopyWith(
    ActivityDetail value,
    $Res Function(ActivityDetail) then,
  ) = _$ActivityDetailCopyWithImpl<$Res, ActivityDetail>;
  @useResult
  $Res call({
    String id,
    String createdByUserId,
    String createdByDisplayName,
    String? createdByAvatarUrl,
    String categoryId,
    String categoryName,
    String? categoryImageUrl,
    String title,
    String? description,
    DateTime eventDate,
    int neededPeopleCount,
    int currentPeopleCount,
    double? pricePerPerson,
    @SkillLevelConverter() SkillLevel skillLevel,
    @GenderPreferenceConverter() GenderPreference genderPreference,
    @ActivityStatusConverter() ActivityStatus status,
    double latitude,
    double longitude,
    String addressText,
    double? distanceMeters,
    DateTime createdAt,
    String? addressDetailPrivate,
    List<PublicProfile> participants,
  });
}

/// @nodoc
class _$ActivityDetailCopyWithImpl<$Res, $Val extends ActivityDetail>
    implements $ActivityDetailCopyWith<$Res> {
  _$ActivityDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdByUserId = null,
    Object? createdByDisplayName = null,
    Object? createdByAvatarUrl = freezed,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? categoryImageUrl = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? eventDate = null,
    Object? neededPeopleCount = null,
    Object? currentPeopleCount = null,
    Object? pricePerPerson = freezed,
    Object? skillLevel = null,
    Object? genderPreference = null,
    Object? status = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? addressText = null,
    Object? distanceMeters = freezed,
    Object? createdAt = null,
    Object? addressDetailPrivate = freezed,
    Object? participants = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            createdByUserId: null == createdByUserId
                ? _value.createdByUserId
                : createdByUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            createdByDisplayName: null == createdByDisplayName
                ? _value.createdByDisplayName
                : createdByDisplayName // ignore: cast_nullable_to_non_nullable
                      as String,
            createdByAvatarUrl: freezed == createdByAvatarUrl
                ? _value.createdByAvatarUrl
                : createdByAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryImageUrl: freezed == categoryImageUrl
                ? _value.categoryImageUrl
                : categoryImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            currentPeopleCount: null == currentPeopleCount
                ? _value.currentPeopleCount
                : currentPeopleCount // ignore: cast_nullable_to_non_nullable
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
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ActivityStatus,
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
            distanceMeters: freezed == distanceMeters
                ? _value.distanceMeters
                : distanceMeters // ignore: cast_nullable_to_non_nullable
                      as double?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            addressDetailPrivate: freezed == addressDetailPrivate
                ? _value.addressDetailPrivate
                : addressDetailPrivate // ignore: cast_nullable_to_non_nullable
                      as String?,
            participants: null == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as List<PublicProfile>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActivityDetailImplCopyWith<$Res>
    implements $ActivityDetailCopyWith<$Res> {
  factory _$$ActivityDetailImplCopyWith(
    _$ActivityDetailImpl value,
    $Res Function(_$ActivityDetailImpl) then,
  ) = __$$ActivityDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String createdByUserId,
    String createdByDisplayName,
    String? createdByAvatarUrl,
    String categoryId,
    String categoryName,
    String? categoryImageUrl,
    String title,
    String? description,
    DateTime eventDate,
    int neededPeopleCount,
    int currentPeopleCount,
    double? pricePerPerson,
    @SkillLevelConverter() SkillLevel skillLevel,
    @GenderPreferenceConverter() GenderPreference genderPreference,
    @ActivityStatusConverter() ActivityStatus status,
    double latitude,
    double longitude,
    String addressText,
    double? distanceMeters,
    DateTime createdAt,
    String? addressDetailPrivate,
    List<PublicProfile> participants,
  });
}

/// @nodoc
class __$$ActivityDetailImplCopyWithImpl<$Res>
    extends _$ActivityDetailCopyWithImpl<$Res, _$ActivityDetailImpl>
    implements _$$ActivityDetailImplCopyWith<$Res> {
  __$$ActivityDetailImplCopyWithImpl(
    _$ActivityDetailImpl _value,
    $Res Function(_$ActivityDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdByUserId = null,
    Object? createdByDisplayName = null,
    Object? createdByAvatarUrl = freezed,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? categoryImageUrl = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? eventDate = null,
    Object? neededPeopleCount = null,
    Object? currentPeopleCount = null,
    Object? pricePerPerson = freezed,
    Object? skillLevel = null,
    Object? genderPreference = null,
    Object? status = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? addressText = null,
    Object? distanceMeters = freezed,
    Object? createdAt = null,
    Object? addressDetailPrivate = freezed,
    Object? participants = null,
  }) {
    return _then(
      _$ActivityDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        createdByUserId: null == createdByUserId
            ? _value.createdByUserId
            : createdByUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        createdByDisplayName: null == createdByDisplayName
            ? _value.createdByDisplayName
            : createdByDisplayName // ignore: cast_nullable_to_non_nullable
                  as String,
        createdByAvatarUrl: freezed == createdByAvatarUrl
            ? _value.createdByAvatarUrl
            : createdByAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryImageUrl: freezed == categoryImageUrl
            ? _value.categoryImageUrl
            : categoryImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        currentPeopleCount: null == currentPeopleCount
            ? _value.currentPeopleCount
            : currentPeopleCount // ignore: cast_nullable_to_non_nullable
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
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ActivityStatus,
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
        distanceMeters: freezed == distanceMeters
            ? _value.distanceMeters
            : distanceMeters // ignore: cast_nullable_to_non_nullable
                  as double?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        addressDetailPrivate: freezed == addressDetailPrivate
            ? _value.addressDetailPrivate
            : addressDetailPrivate // ignore: cast_nullable_to_non_nullable
                  as String?,
        participants: null == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as List<PublicProfile>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityDetailImpl implements _ActivityDetail {
  const _$ActivityDetailImpl({
    required this.id,
    required this.createdByUserId,
    required this.createdByDisplayName,
    this.createdByAvatarUrl,
    required this.categoryId,
    required this.categoryName,
    this.categoryImageUrl,
    required this.title,
    this.description,
    required this.eventDate,
    required this.neededPeopleCount,
    required this.currentPeopleCount,
    this.pricePerPerson,
    @SkillLevelConverter() required this.skillLevel,
    @GenderPreferenceConverter() required this.genderPreference,
    @ActivityStatusConverter() required this.status,
    required this.latitude,
    required this.longitude,
    required this.addressText,
    this.distanceMeters,
    required this.createdAt,
    this.addressDetailPrivate,
    required final List<PublicProfile> participants,
  }) : _participants = participants;

  factory _$ActivityDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityDetailImplFromJson(json);

  @override
  final String id;
  @override
  final String createdByUserId;
  @override
  final String createdByDisplayName;
  @override
  final String? createdByAvatarUrl;
  @override
  final String categoryId;
  @override
  final String categoryName;
  @override
  final String? categoryImageUrl;
  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime eventDate;
  @override
  final int neededPeopleCount;
  @override
  final int currentPeopleCount;
  @override
  final double? pricePerPerson;
  @override
  @SkillLevelConverter()
  final SkillLevel skillLevel;
  @override
  @GenderPreferenceConverter()
  final GenderPreference genderPreference;
  @override
  @ActivityStatusConverter()
  final ActivityStatus status;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String addressText;
  @override
  final double? distanceMeters;
  @override
  final DateTime createdAt;
  @override
  final String? addressDetailPrivate;
  final List<PublicProfile> _participants;
  @override
  List<PublicProfile> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  String toString() {
    return 'ActivityDetail(id: $id, createdByUserId: $createdByUserId, createdByDisplayName: $createdByDisplayName, createdByAvatarUrl: $createdByAvatarUrl, categoryId: $categoryId, categoryName: $categoryName, categoryImageUrl: $categoryImageUrl, title: $title, description: $description, eventDate: $eventDate, neededPeopleCount: $neededPeopleCount, currentPeopleCount: $currentPeopleCount, pricePerPerson: $pricePerPerson, skillLevel: $skillLevel, genderPreference: $genderPreference, status: $status, latitude: $latitude, longitude: $longitude, addressText: $addressText, distanceMeters: $distanceMeters, createdAt: $createdAt, addressDetailPrivate: $addressDetailPrivate, participants: $participants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdByUserId, createdByUserId) ||
                other.createdByUserId == createdByUserId) &&
            (identical(other.createdByDisplayName, createdByDisplayName) ||
                other.createdByDisplayName == createdByDisplayName) &&
            (identical(other.createdByAvatarUrl, createdByAvatarUrl) ||
                other.createdByAvatarUrl == createdByAvatarUrl) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryImageUrl, categoryImageUrl) ||
                other.categoryImageUrl == categoryImageUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.neededPeopleCount, neededPeopleCount) ||
                other.neededPeopleCount == neededPeopleCount) &&
            (identical(other.currentPeopleCount, currentPeopleCount) ||
                other.currentPeopleCount == currentPeopleCount) &&
            (identical(other.pricePerPerson, pricePerPerson) ||
                other.pricePerPerson == pricePerPerson) &&
            (identical(other.skillLevel, skillLevel) ||
                other.skillLevel == skillLevel) &&
            (identical(other.genderPreference, genderPreference) ||
                other.genderPreference == genderPreference) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.addressText, addressText) ||
                other.addressText == addressText) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.addressDetailPrivate, addressDetailPrivate) ||
                other.addressDetailPrivate == addressDetailPrivate) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    createdByUserId,
    createdByDisplayName,
    createdByAvatarUrl,
    categoryId,
    categoryName,
    categoryImageUrl,
    title,
    description,
    eventDate,
    neededPeopleCount,
    currentPeopleCount,
    pricePerPerson,
    skillLevel,
    genderPreference,
    status,
    latitude,
    longitude,
    addressText,
    distanceMeters,
    createdAt,
    addressDetailPrivate,
    const DeepCollectionEquality().hash(_participants),
  ]);

  /// Create a copy of ActivityDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityDetailImplCopyWith<_$ActivityDetailImpl> get copyWith =>
      __$$ActivityDetailImplCopyWithImpl<_$ActivityDetailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityDetailImplToJson(this);
  }
}

abstract class _ActivityDetail implements ActivityDetail {
  const factory _ActivityDetail({
    required final String id,
    required final String createdByUserId,
    required final String createdByDisplayName,
    final String? createdByAvatarUrl,
    required final String categoryId,
    required final String categoryName,
    final String? categoryImageUrl,
    required final String title,
    final String? description,
    required final DateTime eventDate,
    required final int neededPeopleCount,
    required final int currentPeopleCount,
    final double? pricePerPerson,
    @SkillLevelConverter() required final SkillLevel skillLevel,
    @GenderPreferenceConverter()
    required final GenderPreference genderPreference,
    @ActivityStatusConverter() required final ActivityStatus status,
    required final double latitude,
    required final double longitude,
    required final String addressText,
    final double? distanceMeters,
    required final DateTime createdAt,
    final String? addressDetailPrivate,
    required final List<PublicProfile> participants,
  }) = _$ActivityDetailImpl;

  factory _ActivityDetail.fromJson(Map<String, dynamic> json) =
      _$ActivityDetailImpl.fromJson;

  @override
  String get id;
  @override
  String get createdByUserId;
  @override
  String get createdByDisplayName;
  @override
  String? get createdByAvatarUrl;
  @override
  String get categoryId;
  @override
  String get categoryName;
  @override
  String? get categoryImageUrl;
  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime get eventDate;
  @override
  int get neededPeopleCount;
  @override
  int get currentPeopleCount;
  @override
  double? get pricePerPerson;
  @override
  @SkillLevelConverter()
  SkillLevel get skillLevel;
  @override
  @GenderPreferenceConverter()
  GenderPreference get genderPreference;
  @override
  @ActivityStatusConverter()
  ActivityStatus get status;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get addressText;
  @override
  double? get distanceMeters;
  @override
  DateTime get createdAt;
  @override
  String? get addressDetailPrivate;
  @override
  List<PublicProfile> get participants;

  /// Create a copy of ActivityDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityDetailImplCopyWith<_$ActivityDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActivityMapItem _$ActivityMapItemFromJson(Map<String, dynamic> json) {
  return _ActivityMapItem.fromJson(json);
}

/// @nodoc
mixin _$ActivityMapItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  String? get categoryImageUrl => throw _privateConstructorUsedError;
  @ActivityStatusConverter()
  ActivityStatus get status => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  DateTime get eventDate => throw _privateConstructorUsedError;
  int get neededPeopleCount => throw _privateConstructorUsedError;
  double? get pricePerPerson => throw _privateConstructorUsedError;
  double get distanceMeters => throw _privateConstructorUsedError;

  /// Serializes this ActivityMapItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityMapItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityMapItemCopyWith<ActivityMapItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityMapItemCopyWith<$Res> {
  factory $ActivityMapItemCopyWith(
    ActivityMapItem value,
    $Res Function(ActivityMapItem) then,
  ) = _$ActivityMapItemCopyWithImpl<$Res, ActivityMapItem>;
  @useResult
  $Res call({
    String id,
    String title,
    String categoryName,
    String? categoryImageUrl,
    @ActivityStatusConverter() ActivityStatus status,
    double latitude,
    double longitude,
    DateTime eventDate,
    int neededPeopleCount,
    double? pricePerPerson,
    double distanceMeters,
  });
}

/// @nodoc
class _$ActivityMapItemCopyWithImpl<$Res, $Val extends ActivityMapItem>
    implements $ActivityMapItemCopyWith<$Res> {
  _$ActivityMapItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityMapItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? categoryName = null,
    Object? categoryImageUrl = freezed,
    Object? status = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? eventDate = null,
    Object? neededPeopleCount = null,
    Object? pricePerPerson = freezed,
    Object? distanceMeters = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryImageUrl: freezed == categoryImageUrl
                ? _value.categoryImageUrl
                : categoryImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ActivityStatus,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
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
            distanceMeters: null == distanceMeters
                ? _value.distanceMeters
                : distanceMeters // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActivityMapItemImplCopyWith<$Res>
    implements $ActivityMapItemCopyWith<$Res> {
  factory _$$ActivityMapItemImplCopyWith(
    _$ActivityMapItemImpl value,
    $Res Function(_$ActivityMapItemImpl) then,
  ) = __$$ActivityMapItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String categoryName,
    String? categoryImageUrl,
    @ActivityStatusConverter() ActivityStatus status,
    double latitude,
    double longitude,
    DateTime eventDate,
    int neededPeopleCount,
    double? pricePerPerson,
    double distanceMeters,
  });
}

/// @nodoc
class __$$ActivityMapItemImplCopyWithImpl<$Res>
    extends _$ActivityMapItemCopyWithImpl<$Res, _$ActivityMapItemImpl>
    implements _$$ActivityMapItemImplCopyWith<$Res> {
  __$$ActivityMapItemImplCopyWithImpl(
    _$ActivityMapItemImpl _value,
    $Res Function(_$ActivityMapItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityMapItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? categoryName = null,
    Object? categoryImageUrl = freezed,
    Object? status = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? eventDate = null,
    Object? neededPeopleCount = null,
    Object? pricePerPerson = freezed,
    Object? distanceMeters = null,
  }) {
    return _then(
      _$ActivityMapItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryImageUrl: freezed == categoryImageUrl
            ? _value.categoryImageUrl
            : categoryImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ActivityStatus,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
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
        distanceMeters: null == distanceMeters
            ? _value.distanceMeters
            : distanceMeters // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityMapItemImpl implements _ActivityMapItem {
  const _$ActivityMapItemImpl({
    required this.id,
    required this.title,
    required this.categoryName,
    this.categoryImageUrl,
    @ActivityStatusConverter() required this.status,
    required this.latitude,
    required this.longitude,
    required this.eventDate,
    required this.neededPeopleCount,
    this.pricePerPerson,
    required this.distanceMeters,
  });

  factory _$ActivityMapItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityMapItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String categoryName;
  @override
  final String? categoryImageUrl;
  @override
  @ActivityStatusConverter()
  final ActivityStatus status;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final DateTime eventDate;
  @override
  final int neededPeopleCount;
  @override
  final double? pricePerPerson;
  @override
  final double distanceMeters;

  @override
  String toString() {
    return 'ActivityMapItem(id: $id, title: $title, categoryName: $categoryName, categoryImageUrl: $categoryImageUrl, status: $status, latitude: $latitude, longitude: $longitude, eventDate: $eventDate, neededPeopleCount: $neededPeopleCount, pricePerPerson: $pricePerPerson, distanceMeters: $distanceMeters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityMapItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryImageUrl, categoryImageUrl) ||
                other.categoryImageUrl == categoryImageUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.neededPeopleCount, neededPeopleCount) ||
                other.neededPeopleCount == neededPeopleCount) &&
            (identical(other.pricePerPerson, pricePerPerson) ||
                other.pricePerPerson == pricePerPerson) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    categoryName,
    categoryImageUrl,
    status,
    latitude,
    longitude,
    eventDate,
    neededPeopleCount,
    pricePerPerson,
    distanceMeters,
  );

  /// Create a copy of ActivityMapItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityMapItemImplCopyWith<_$ActivityMapItemImpl> get copyWith =>
      __$$ActivityMapItemImplCopyWithImpl<_$ActivityMapItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityMapItemImplToJson(this);
  }
}

abstract class _ActivityMapItem implements ActivityMapItem {
  const factory _ActivityMapItem({
    required final String id,
    required final String title,
    required final String categoryName,
    final String? categoryImageUrl,
    @ActivityStatusConverter() required final ActivityStatus status,
    required final double latitude,
    required final double longitude,
    required final DateTime eventDate,
    required final int neededPeopleCount,
    final double? pricePerPerson,
    required final double distanceMeters,
  }) = _$ActivityMapItemImpl;

  factory _ActivityMapItem.fromJson(Map<String, dynamic> json) =
      _$ActivityMapItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get categoryName;
  @override
  String? get categoryImageUrl;
  @override
  @ActivityStatusConverter()
  ActivityStatus get status;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  DateTime get eventDate;
  @override
  int get neededPeopleCount;
  @override
  double? get pricePerPerson;
  @override
  double get distanceMeters;

  /// Create a copy of ActivityMapItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityMapItemImplCopyWith<_$ActivityMapItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
