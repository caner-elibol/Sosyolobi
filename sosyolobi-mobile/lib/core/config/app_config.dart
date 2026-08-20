import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

/// Resolves the backend API base URL.
///
/// Precedence:
/// 1. `--dart-define=API_BASE_URL=...` (or `--dart-define-from-file=env/*.json`)
///    — always wins, used for physical-device testing against a LAN IP and
///    for prod builds.
/// 2. Platform default — `10.0.2.2` on the Android emulator (loopback to the
///    host machine), `localhost` everywhere else (iOS simulator, web, desktop).
abstract final class AppConfig {
  static const _override = String.fromEnvironment('API_BASE_URL');

  static const _devPort = 5000;

  static String get apiBaseUrl {
    if (_override.isNotEmpty) return _override;
    if (kIsWeb) return 'http://localhost:$_devPort';
    if (Platform.isAndroid) return 'http://10.0.2.2:$_devPort';
    return 'http://localhost:$_devPort';
  }

  static String get chatHubUrl => '$apiBaseUrl/hubs/chat';
  static String get notificationHubUrl => '$apiBaseUrl/hubs/notifications';
}
