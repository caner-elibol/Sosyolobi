import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../../core/realtime/hub_connection_factory.dart';
import '../../auth/application/auth_notifier.dart';
import 'notifications_controller.dart';

part 'notification_hub_provider.g.dart';

/// App-wide NotificationHub connection (unlike [ChatMessagesNotifier]'s
/// per-panel connection — the notification badge is visible everywhere via
/// [AppShell], so this one lives for the whole authenticated session).
/// `NotificationHub` has no client-invokable methods; it auto-joins group
/// `user_{userId}` on connect and pushes `ReceiveNotification`. On receipt
/// we simply refetch (`invalidate`) the notifications list rather than
/// hand-merge the pushed payload — one source of truth, no dedup logic to
/// get wrong. The 5s poll in [NotificationsController] remains as a
/// reconnect-gap backstop, matching plan's "prefer push, keep a backstop".
@Riverpod(keepAlive: true)
class NotificationHub extends _$NotificationHub {
  HubConnection? _connection;

  @override
  Future<void> build() async {
    final authState = await ref.watch(authNotifierProvider.future);
    ref.onDispose(_disconnect);

    if (!authState.isAuthenticated) {
      await _disconnect();
      return;
    }

    await _connect();
  }

  Future<void> _connect() async {
    if (_connection != null) return;
    final tokenStorage = ref.read(tokenStorageProvider);
    final connection = buildHubConnection(AppConfig.notificationHubUrl, tokenStorage);
    _connection = connection;

    connection.on('ReceiveNotification', (arguments) {
      ref.invalidate(notificationsControllerProvider);
    });

    try {
      await connection.start();
    } catch (_) {
      // Best-effort — the 5s poll in NotificationsController still covers
      // this session if the realtime channel fails to connect.
    }
  }

  Future<void> _disconnect() async {
    final connection = _connection;
    _connection = null;
    if (connection == null) return;
    await connection.stop();
  }
}
