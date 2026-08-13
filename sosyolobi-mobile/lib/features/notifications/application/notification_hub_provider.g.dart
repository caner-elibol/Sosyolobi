// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_hub_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationHubHash() => r'4a601d2bc99425106cf5d34865ee378b81eacda8';

/// App-wide NotificationHub connection (unlike [ChatMessagesNotifier]'s
/// per-panel connection — the notification badge is visible everywhere via
/// [AppShell], so this one lives for the whole authenticated session).
/// `NotificationHub` has no client-invokable methods; it auto-joins group
/// `user_{userId}` on connect and pushes `ReceiveNotification`. On receipt
/// we simply refetch (`invalidate`) the notifications list rather than
/// hand-merge the pushed payload — one source of truth, no dedup logic to
/// get wrong. The 5s poll in [NotificationsController] remains as a
/// reconnect-gap backstop, matching plan's "prefer push, keep a backstop".
///
/// Copied from [NotificationHub].
@ProviderFor(NotificationHub)
final notificationHubProvider =
    AsyncNotifierProvider<NotificationHub, void>.internal(
      NotificationHub.new,
      name: r'notificationHubProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationHubHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationHub = AsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
