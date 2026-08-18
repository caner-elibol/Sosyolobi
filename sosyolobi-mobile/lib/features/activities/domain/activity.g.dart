// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      id: json['id'] as String,
      createdByUserId: json['createdByUserId'] as String,
      createdByDisplayName: json['createdByDisplayName'] as String,
      createdByAvatarUrl: json['createdByAvatarUrl'] as String?,
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      categoryImageUrl: json['categoryImageUrl'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      eventDate: DateTime.parse(json['eventDate'] as String),
      neededPeopleCount: (json['neededPeopleCount'] as num).toInt(),
      currentPeopleCount: (json['currentPeopleCount'] as num).toInt(),
      pricePerPerson: (json['pricePerPerson'] as num?)?.toDouble(),
      skillLevel: const SkillLevelConverter().fromJson(
        (json['skillLevel'] as num).toInt(),
      ),
      genderPreference: const GenderPreferenceConverter().fromJson(
        (json['genderPreference'] as num).toInt(),
      ),
      status: const ActivityStatusConverter().fromJson(
        (json['status'] as num).toInt(),
      ),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      addressText: json['addressText'] as String,
      distanceMeters: (json['distanceMeters'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdByUserId': instance.createdByUserId,
      'createdByDisplayName': instance.createdByDisplayName,
      'createdByAvatarUrl': instance.createdByAvatarUrl,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'categoryImageUrl': instance.categoryImageUrl,
      'title': instance.title,
      'description': instance.description,
      'eventDate': instance.eventDate.toIso8601String(),
      'neededPeopleCount': instance.neededPeopleCount,
      'currentPeopleCount': instance.currentPeopleCount,
      'pricePerPerson': instance.pricePerPerson,
      'skillLevel': const SkillLevelConverter().toJson(instance.skillLevel),
      'genderPreference': const GenderPreferenceConverter().toJson(
        instance.genderPreference,
      ),
      'status': const ActivityStatusConverter().toJson(instance.status),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'addressText': instance.addressText,
      'distanceMeters': instance.distanceMeters,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$ActivityDetailImpl _$$ActivityDetailImplFromJson(Map<String, dynamic> json) =>
    _$ActivityDetailImpl(
      id: json['id'] as String,
      createdByUserId: json['createdByUserId'] as String,
      createdByDisplayName: json['createdByDisplayName'] as String,
      createdByAvatarUrl: json['createdByAvatarUrl'] as String?,
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      categoryImageUrl: json['categoryImageUrl'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      eventDate: DateTime.parse(json['eventDate'] as String),
      neededPeopleCount: (json['neededPeopleCount'] as num).toInt(),
      currentPeopleCount: (json['currentPeopleCount'] as num).toInt(),
      pricePerPerson: (json['pricePerPerson'] as num?)?.toDouble(),
      skillLevel: const SkillLevelConverter().fromJson(
        (json['skillLevel'] as num).toInt(),
      ),
      genderPreference: const GenderPreferenceConverter().fromJson(
        (json['genderPreference'] as num).toInt(),
      ),
      status: const ActivityStatusConverter().fromJson(
        (json['status'] as num).toInt(),
      ),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      addressText: json['addressText'] as String,
      distanceMeters: (json['distanceMeters'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      addressDetailPrivate: json['addressDetailPrivate'] as String?,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => PublicProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
      myRequestStatus: json['myRequestStatus'] == null
          ? null
          : const ActivityRequestStatusConverter().fromJson(
              (json['myRequestStatus'] as num).toInt(),
            ),
    );

Map<String, dynamic> _$$ActivityDetailImplToJson(
  _$ActivityDetailImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdByUserId': instance.createdByUserId,
  'createdByDisplayName': instance.createdByDisplayName,
  'createdByAvatarUrl': instance.createdByAvatarUrl,
  'categoryId': instance.categoryId,
  'categoryName': instance.categoryName,
  'categoryImageUrl': instance.categoryImageUrl,
  'title': instance.title,
  'description': instance.description,
  'eventDate': instance.eventDate.toIso8601String(),
  'neededPeopleCount': instance.neededPeopleCount,
  'currentPeopleCount': instance.currentPeopleCount,
  'pricePerPerson': instance.pricePerPerson,
  'skillLevel': const SkillLevelConverter().toJson(instance.skillLevel),
  'genderPreference': const GenderPreferenceConverter().toJson(
    instance.genderPreference,
  ),
  'status': const ActivityStatusConverter().toJson(instance.status),
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'addressText': instance.addressText,
  'distanceMeters': instance.distanceMeters,
  'createdAt': instance.createdAt.toIso8601String(),
  'addressDetailPrivate': instance.addressDetailPrivate,
  'participants': instance.participants,
  'myRequestStatus': instance.myRequestStatus == null
      ? null
      : const ActivityRequestStatusConverter().toJson(
          instance.myRequestStatus!,
        ),
};

_$ActivityMapItemImpl _$$ActivityMapItemImplFromJson(
  Map<String, dynamic> json,
) => _$ActivityMapItemImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  categoryName: json['categoryName'] as String,
  categoryImageUrl: json['categoryImageUrl'] as String?,
  status: const ActivityStatusConverter().fromJson(
    (json['status'] as num).toInt(),
  ),
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  eventDate: DateTime.parse(json['eventDate'] as String),
  neededPeopleCount: (json['neededPeopleCount'] as num).toInt(),
  pricePerPerson: (json['pricePerPerson'] as num?)?.toDouble(),
  distanceMeters: (json['distanceMeters'] as num).toDouble(),
);

Map<String, dynamic> _$$ActivityMapItemImplToJson(
  _$ActivityMapItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'categoryName': instance.categoryName,
  'categoryImageUrl': instance.categoryImageUrl,
  'status': const ActivityStatusConverter().toJson(instance.status),
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'eventDate': instance.eventDate.toIso8601String(),
  'neededPeopleCount': instance.neededPeopleCount,
  'pricePerPerson': instance.pricePerPerson,
  'distanceMeters': instance.distanceMeters,
};
