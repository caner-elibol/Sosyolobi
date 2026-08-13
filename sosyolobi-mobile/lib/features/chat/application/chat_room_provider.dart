import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/chat_api.dart';
import '../domain/chat.dart';

part 'chat_room_provider.g.dart';

/// Mirrors `useChatRoom` in `sosyolobi-web-2/src/hooks/useChatRoom.ts`.
@riverpod
Future<ChatRoom> chatRoom(Ref ref, String activityId) => ref.watch(chatApiProvider).getRoom(activityId);
