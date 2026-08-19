import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'poll_ticker.g.dart';

/// Single shared 5-second heartbeat for badge-count polling.
///
/// `NotificationsController` and `ChatUnread` each used to own an
/// independent `Timer.periodic(Duration(seconds: 5))`, so the app fired two
/// separate, phase-drifted background requests (`/api/notifications` and
/// `/api/chat-rooms/unread-summary`) every ~5s for as long as the app was
/// open — double the radio wake-ups for no benefit, since both exist purely
/// to refresh badge counts. Both now `ref.watch` this ticker instead of
/// running their own `Timer`, so they rebuild (and refetch) in the same
/// tick — same 5s cadence per `useNotifications.ts`/`useChatUnread.ts`
/// parity, half the wake-ups.
///
/// Emits an incrementing `int`, not `void` — this was `Stream<void>` before
/// the Riverpod 3.x upgrade, which broke polling silently: Riverpod 3.x's
/// default `updateShouldNotify` is plain `previous != next` (no more special
/// case for data-to-data async transitions like 2.x had), and every
/// `AsyncData<void>(null)` tick compares equal to the last, so dependents
/// stopped rebuilding after the first tick — confirmed as the cause of
/// notifications/chat-unread going stale after the dependency upgrade. Each
/// `int` tick is distinct, so `updateShouldNotify` correctly fires every 5s
/// again.
@Riverpod(keepAlive: true)
Stream<int> pollTicker(Ref ref) {
  return Stream<int>.periodic(const Duration(seconds: 5), (tick) => tick);
}
