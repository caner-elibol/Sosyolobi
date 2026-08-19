import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/polling/poll_ticker.dart';
import '../../auth/application/auth_notifier.dart';
import '../data/chat_api.dart';
import '../domain/chat.dart';

part 'chat_unread_provider.g.dart';

/// Mirrors `useChatUnread` in `sosyolobi-web-2/src/hooks/useChatUnread.ts` —
/// including its literal `refetchInterval: 5_000` poll (there is no
/// app-wide SignalR connection to push this reactively in this client's
/// design, see [ChatMessagesNotifier]'s per-panel connection lifecycle;
/// web polls for exactly the same reason its own hub connection is
/// per-`ChatPanel`-mount, not app-wide) — via the shared [pollTickerProvider]
/// rather than an own `Timer`, see that provider's doc for why.
///
/// Watches [authProvider] (same fix as `MyProfile` in
/// `profile_providers.dart`) so switching users rebuilds immediately instead
/// of showing the previous user's unread counts for up to 5s until the next
/// tick, and so no request fires (and hits a 401) on ticks while logged out.
@Riverpod(keepAlive: true)
class ChatUnread extends _$ChatUnread {
  @override
  Future<List<ChatUnreadSummary>> build() async {
    ref.watch(pollTickerProvider);
    final authState = await ref.watch(authProvider.future);
    if (!authState.isAuthenticated) return const [];

    return ref.watch(chatApiProvider).unreadSummary();
  }

  Future<void> markRead(String roomId) async {
    await ref.read(chatApiProvider).markRead(roomId);
    ref.invalidateSelf();
  }
}

/// Total unread chat rooms — feeds into the combined notification badge
/// (`AppTopbar.tsx`'s `badgeCount = unreadCount + totalUnreadRooms`).
@riverpod
int totalUnreadChatRooms(Ref ref) {
  return ref.watch(chatUnreadProvider).value?.length ?? 0;
}
