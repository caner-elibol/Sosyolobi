import 'chat.dart';

/// Live view-state for one open [ChatPanel] — messages newest-first plus
/// whether `RoomClosed` has fired since the panel opened.
class ChatRoomState {
  const ChatRoomState({required this.messages, required this.closed});

  final List<ChatMessage> messages;
  final bool closed;

  ChatRoomState copyWith({List<ChatMessage>? messages, bool? closed}) {
    return ChatRoomState(messages: messages ?? this.messages, closed: closed ?? this.closed);
  }
}
