import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/chat_api.dart';
import '../domain/chat.dart';

part 'chat_unread_provider.g.dart';

/// Mirrors `useChatUnread` in `sosyolobi-web-2/src/hooks/useChatUnread.ts` —
/// including its literal `refetchInterval: 5_000` poll (there is no
/// app-wide SignalR connection to push this reactively in this client's
/// design, see [ChatMessagesNotifier]'s per-panel connection lifecycle;
/// web polls for exactly the same reason its own hub connection is
/// per-`ChatPanel`-mount, not app-wide).
@Riverpod(keepAlive: true)
class ChatUnread extends _$ChatUnread {
  Timer? _timer;

  @override
  Future<List<ChatUnreadSummary>> build() async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => ref.invalidateSelf());
    ref.onDispose(() => _timer?.cancel());
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
  return ref.watch(chatUnreadProvider).valueOrNull?.length ?? 0;
}
