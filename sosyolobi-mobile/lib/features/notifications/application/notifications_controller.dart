import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/polling/poll_ticker.dart';
import '../../auth/application/auth_notifier.dart';
import '../data/notifications_api.dart';
import '../domain/notification.dart';

part 'notifications_controller.g.dart';

/// Mirrors `useNotifications` in
/// `sosyolobi-web-2/src/hooks/useNotifications.ts`, including its literal
/// `refetchInterval: 5_000` poll — via the shared [pollTickerProvider]
/// rather than an own `Timer`, see that provider's doc for why.
///
/// Watches [authProvider] (same fix as `MyProfile` in
/// `profile_providers.dart`) so switching users rebuilds immediately instead
/// of showing the previous user's notifications for up to 5s, and so no
/// request fires (and hits a 401) on ticks while logged out.
@Riverpod(keepAlive: true)
class NotificationsController extends _$NotificationsController {
  @override
  Future<List<AppNotification>> build() async {
    ref.watch(pollTickerProvider);
    final authState = await ref.watch(authProvider.future);
    if (!authState.isAuthenticated) return const [];

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
      ref.watch(notificationsControllerProvider).value ?? const [];
  return notifications.where((n) => !n.isRead).length;
}
