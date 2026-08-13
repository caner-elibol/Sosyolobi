import 'package:json_annotation/json_annotation.dart';

import 'enums.dart';

/// `JsonConverter`s for the int-backed enums in `enums.dart` — needed
/// because their wire values don't match Dart's enum declaration order for
/// every case (e.g. `SkillLevel.any == 0`), so json_serializable's default
/// by-name/by-index mapping can't be used.
class ActivityStatusConverter implements JsonConverter<ActivityStatus, int> {
  const ActivityStatusConverter();
  @override
  ActivityStatus fromJson(int json) => ActivityStatus.fromJson(json);
  @override
  int toJson(ActivityStatus object) => object.toJson();
}

class ActivityRequestStatusConverter implements JsonConverter<ActivityRequestStatus, int> {
  const ActivityRequestStatusConverter();
  @override
  ActivityRequestStatus fromJson(int json) => ActivityRequestStatus.fromJson(json);
  @override
  int toJson(ActivityRequestStatus object) => object.toJson();
}

class SkillLevelConverter implements JsonConverter<SkillLevel, int> {
  const SkillLevelConverter();
  @override
  SkillLevel fromJson(int json) => SkillLevel.fromJson(json);
  @override
  int toJson(SkillLevel object) => object.toJson();
}

class GenderPreferenceConverter implements JsonConverter<GenderPreference, int> {
  const GenderPreferenceConverter();
  @override
  GenderPreference fromJson(int json) => GenderPreference.fromJson(json);
  @override
  int toJson(GenderPreference object) => object.toJson();
}

class ChatRoomStatusConverter implements JsonConverter<ChatRoomStatus, int> {
  const ChatRoomStatusConverter();
  @override
  ChatRoomStatus fromJson(int json) => ChatRoomStatus.fromJson(json);
  @override
  int toJson(ChatRoomStatus object) => object.toJson();
}

class NotificationTypeConverter implements JsonConverter<NotificationType, int> {
  const NotificationTypeConverter();
  @override
  NotificationType fromJson(int json) => NotificationType.fromJson(json);
  @override
  int toJson(NotificationType object) => object.toJson();
}

class ReportStatusConverter implements JsonConverter<ReportStatus, int> {
  const ReportStatusConverter();
  @override
  ReportStatus fromJson(int json) => ReportStatus.fromJson(json);
  @override
  int toJson(ReportStatus object) => object.toJson();
}
