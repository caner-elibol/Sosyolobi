// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$unreadNotificationsCountHash() =>
    r'65038b7d74c83f854d23b22ff3e8188e759e8ffc';

/// See also [unreadNotificationsCount].
@ProviderFor(unreadNotificationsCount)
final unreadNotificationsCountProvider = AutoDisposeProvider<int>.internal(
  unreadNotificationsCount,
  name: r'unreadNotificationsCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadNotificationsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnreadNotificationsCountRef = AutoDisposeProviderRef<int>;
String _$notificationsControllerHash() =>
    r'6c0160437a8a3c19f7c38947df6f9c453efd00fd';

/// Mirrors `useNotifications` in
/// `sosyolobi-web-2/src/hooks/useNotifications.ts`, including its literal
/// `refetchInterval: 5_000` poll.
///
/// Copied from [NotificationsController].
@ProviderFor(NotificationsController)
final notificationsControllerProvider =
    AsyncNotifierProvider<
      NotificationsController,
      List<AppNotification>
    >.internal(
      NotificationsController.new,
      name: r'notificationsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationsController = AsyncNotifier<List<AppNotification>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
