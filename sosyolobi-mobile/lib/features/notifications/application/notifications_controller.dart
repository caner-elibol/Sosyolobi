import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/application/auth_notifier.dart';
import '../data/notifications_api.dart';
import '../domain/notification.dart';

part 'notifications_controller.g.dart';

/// Mirrors `useNotifications` in
/// `sosyolobi-web-2/src/hooks/useNotifications.ts`, including its literal
/// `refetchInterval: 5_000` poll.
///
/// Watches [authNotifierProvider] (same fix as `MyProfile` in
/// `profile_providers.dart`) so switching users rebuilds immediately instead
/// of showing the previous user's notifications for up to 5s, and so the
/// timer stops polling (and hitting 401s) while logged out.
@Riverpod(keepAlive: true)
class NotificationsController extends _$NotificationsController {
  Timer? _timer;

  @override
  Future<List<AppNotification>> build() async {
    _timer?.cancel();
    final authState = await ref.watch(authNotifierProvider.future);
    if (!authState.isAuthenticated) return const [];

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => ref.invalidateSelf(),
    );
    ref.onDispose(() => _timer?.cancel());
    return ref.watch(notificationsApiProvider).getAll();
  }

  Future<void> markRead(String id) async {
    await ref.read(notificationsApiProvider).markRead(id);
    ref.invalidateSelf();
  }

  Future<void> markAllRead() async {
    await ref.read(notificationsApiProvider).markAllRead();
    ref.invalidateSelf();
  }
}

@riverpod
int unreadNotificationsCount(Ref ref) {
  final notifications =
      ref.watch(notificationsControllerProvider).valueOrNull ?? const [];
  return notifications.where((n) => !n.isRead).length;
}
