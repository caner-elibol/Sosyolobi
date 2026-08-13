// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$unreadBadgeCountHash() => r'b83b56485bf4cd738b1398cdc6030caf56ae7e5b';

/// Combined notifications-unread + chat-unread badge count, mirrors
/// `AppTopbar.tsx`'s `badgeCount = unreadCount + totalUnreadRooms`.
///
/// Copied from [unreadBadgeCount].
@ProviderFor(unreadBadgeCount)
final unreadBadgeCountProvider = AutoDisposeProvider<int>.internal(
  unreadBadgeCount,
  name: r'unreadBadgeCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadBadgeCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnreadBadgeCountRef = AutoDisposeProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
