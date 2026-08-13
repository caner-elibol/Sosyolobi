import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/notifications_api.dart';
import '../domain/notification.dart';

part 'notifications_controller.g.dart';

/// Mirrors `useNotifications` in
/// `sosyolobi-web-2/src/hooks/useNotifications.ts`, including its literal
/// `refetchInterval: 5_000` poll.
@Riverpod(keepAlive: true)
class NotificationsController extends _$NotificationsController {
  Timer? _timer;

  @override
  Future<List<AppNotification>> build() async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => ref.invalidateSelf());
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
  final notifications = ref.watch(notificationsControllerProvider).valueOrNull ?? const [];
  return notifications.where((n) => !n.isRead).length;
}
