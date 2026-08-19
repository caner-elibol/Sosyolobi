import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../../core/realtime/hub_connection_factory.dart';
import '../data/chat_api.dart';
import '../domain/chat.dart';
import '../domain/chat_room_state.dart';
import 'chat_unread_provider.dart';

part 'chat_messages_notifier.g.dart';

/// Mirrors `ChatPanel.tsx`'s effect: builds a fresh ChatHub connection when
/// the panel (this provider) is created, joins the room, listens for
/// `ReceiveMessage`/`RoomClosed`, and tears the connection down on dispose —
/// exactly web's per-mount connection lifecycle, not an app-wide singleton.
@riverpod
class ChatMessagesNotifier extends _$ChatMessagesNotifier {
  HubConnection? _connection;

  @override
  Future<ChatRoomState> build(String roomId) async {
    final page = await ref.read(chatApiProvider).getMessages(roomId);
    // Backend returns newest-first per page; web reverses to oldest-first
    // for top-to-bottom rendering with a bottom-anchored scroll.
    final messages = page.items.reversed.toList();

    ref.onDispose(_disconnectHub);
    // Hub connect (websocket negotiate + JoinRoom) doesn't gate the initial
    // render — it used to be awaited here, so a slow SignalR handshake on
    // mobile networks delayed showing messages that had already arrived via
    // REST (confirmed: chat felt slow to open even though REST calls in the
    // logs all returned in under a second — the SignalR traffic isn't
    // logged by Dio, so the delay was invisible there). `_connectHub` is
    // already best-effort/error-swallowing, so it's safe to run unawaited.
    unawaited(_connectHub(roomId));

    // Mark read on open, mirrors ChatPanel.tsx's mount-time markChatRead.
    ref.read(chatApiProvider).markRead(roomId);

    return ChatRoomState(messages: messages, closed: false);
  }

  Future<void> _connectHub(String roomId) async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final connection = buildHubConnection(AppConfig.chatHubUrl, tokenStorage);
    _connection = connection;

    connection.on('ReceiveMessage', (arguments) {
      final json = arguments?.first as Map<String, dynamic>?;
      if (json == null) return;
      final message = ChatMessage.fromJson(json);
      if (message.chatRoomId != roomId) return;
      final current = state.value;
      if (current == null || current.messages.any((m) => m.id == message.id)) return;
      state = AsyncData(current.copyWith(messages: [...current.messages, message]));
      ref.read(chatApiProvider).markRead(roomId);
      ref.read(chatUnreadProvider.notifier).markRead(roomId);
    });

    connection.on('RoomClosed', (arguments) {
      final json = arguments?.first as Map<String, dynamic>?;
      if (json == null || json['id'] != roomId) return;
      final current = state.value;
      if (current == null) return;
      state = AsyncData(current.copyWith(closed: true));
    });

    try {
      await connection.start();
      await connection.invoke('JoinRoom', args: [roomId]);
    } catch (_) {
      // Best-effort — messages still work via REST polling/refetch even if
      // the realtime channel fails to connect.
    }
  }

  Future<void> _disconnectHub() async {
    final connection = _connection;
    _connection = null;
    if (connection == null) return;
    try {
      await connection.invoke('LeaveRoom', args: [roomId]);
    } catch (_) {}
    // Connect no longer blocks `build()` (see above), so dispose can now
    // race an in-progress `connection.start()` (e.g. user backs out fast) —
    // stop() on a still-connecting connection isn't guaranteed safe by
    // every signalr_netcore transport, so this is best-effort too.
    try {
      await connection.stop();
    } catch (_) {}
  }

  Future<ChatMessage> sendMessage({required String content, String? replyToMessageId}) async {
    final message = await ref.read(chatApiProvider).sendMessage(roomId, content: content, replyToMessageId: replyToMessageId);
    final current = state.value;
    if (current != null && !current.messages.any((m) => m.id == message.id)) {
      state = AsyncData(current.copyWith(messages: [...current.messages, message]));
    }
    return message;
  }
}
