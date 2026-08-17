import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/enum_converters.dart';
import '../../../core/domain/enums.dart';
import '../../profile/domain/profile.dart';

part 'friend.freezed.dart';
part 'friend.g.dart';

/// Mirrors `Sosyolobi.Api/DTOs/Friends/FriendResponse.cs`.
@freezed
abstract class Friend with _$Friend {
  const factory Friend({
    required DateTime friendsSinceUtc,
    required PublicProfile user,
  }) = _Friend;

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);
}

/// Mirrors `Sosyolobi.Api/DTOs/Friends/FriendRequestResponse.cs`.
@freezed
abstract class FriendRequest with _$FriendRequest {
  const factory FriendRequest({
    required String id,
    @FriendRequestStatusConverter() required FriendRequestStatus status,
    required DateTime createdAt,
    DateTime? respondedAt,
    required PublicProfile user,
  }) = _FriendRequest;

  factory FriendRequest.fromJson(Map<String, dynamic> json) => _$FriendRequestFromJson(json);
}
