import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../chat/application/chat_unread_provider.dart';
import 'notifications_controller.dart';

part 'notifications_providers.g.dart';

/// Combined notifications-unread + chat-unread badge count, mirrors
/// `AppTopbar.tsx`'s `badgeCount = unreadCount + totalUnreadRooms`.
@riverpod
int unreadBadgeCount(Ref ref) {
  return ref.watch(unreadNotificationsCountProvider) + ref.watch(totalUnreadChatRoomsProvider);
}
