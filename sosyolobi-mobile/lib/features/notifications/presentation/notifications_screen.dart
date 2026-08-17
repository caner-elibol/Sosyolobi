import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/enums.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_widget.dart';
import '../../../core/widgets/empty_state.dart';
import '../../chat/application/chat_unread_provider.dart';
import '../../chat/domain/chat.dart';
import '../application/notifications_controller.dart';
import '../domain/notification.dart';

const _notifIcons = {
  NotificationType.activityRequest: Icons.notifications_active_outlined,
  NotificationType.requestApproved: Icons.check_circle_outline,
  NotificationType.requestRejected: Icons.cancel_outlined,
  NotificationType.activityCancelled: Icons.block,
  NotificationType.activityCompleted: Icons.check_circle,
  NotificationType.newReview: Icons.star_outline,
  NotificationType.newReport: Icons.warning_amber_outlined,
};

class _FeedItem {
  const _FeedItem({
    required this.key,
    required this.icon,
    required this.title,
    this.message,
    this.activityTitle,
    required this.isRead,
    required this.createdAt,
    required this.onOpen,
  });

  final String key;
  final IconData icon;
  final String title;
  final String? message;
  final String? activityTitle;
  final bool isRead;
  final DateTime createdAt;
  final VoidCallback onOpen;
}

/// Ports `sosyolobi-web-2/src/app/(user)/app/notifications/page.tsx` — merges
/// notifications + chat-unread summaries into one feed, sorted newest first.
///
/// Web converted this from a page to a bell-icon dropdown panel where
/// opening it auto-marks visible notifications as read (no separate
/// "mark all read" action). A dedicated full-screen view is still a natural
/// mobile pattern (kept here, unlike web's dropdown), but the auto-mark-on-
/// open behavior is ported: opening this screen marks every currently
/// fetched notification read exactly once, and the manual "mark all read"
/// button is removed as redundant.
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  bool _markedThisOpen = false;

  void _maybeAutoMarkRead(List<AppNotification> notifications) {
    if (_markedThisOpen || !notifications.any((n) => !n.isRead)) return;
    _markedThisOpen = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationsControllerProvider.notifier).markAllRead();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationsControllerProvider);
    final chatUnreadAsync = ref.watch(chatUnreadProvider);
    final unreadCount = ref.watch(unreadNotificationsCountProvider);
    final totalUnreadChatRooms = ref.watch(totalUnreadChatRoomsProvider);
    final totalUnread = unreadCount + totalUnreadChatRooms;

    final loadedNotifications = notificationsAsync.valueOrNull;
    if (loadedNotifications != null) _maybeAutoMarkRead(loadedNotifications);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Bildirimler'),
            if (totalUnread > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(AppRadius.full)),
                child: Text('$totalUnread', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ],
          ],
        ),
      ),
      body: AsyncValueWidget<List<AppNotification>>(
        value: notificationsAsync,
        data: (notifications) => AsyncValueWidget<List<ChatUnreadSummary>>(
          value: chatUnreadAsync,
          data: (chatUnread) => _buildList(context, ref, notifications, chatUnread),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, WidgetRef ref, List<AppNotification> notifications, List<ChatUnreadSummary> chatUnread) {
    final now = DateTime.now();
    final items = <_FeedItem>[
      for (final n in notifications)
        _FeedItem(
          key: 'n-${n.id}',
          icon: _notifIcons[n.type] ?? Icons.notifications_outlined,
          title: n.title,
          message: n.message,
          activityTitle: n.relatedActivityTitle,
          isRead: n.isRead,
          createdAt: n.createdAt,
          onOpen: () {
            if (!n.isRead) ref.read(notificationsControllerProvider.notifier).markRead(n.id);
            if (n.relatedActivityId != null) context.push(RoutePaths.activityDetail(n.relatedActivityId!));
          },
        ),
      for (final c in chatUnread)
        _FeedItem(
          key: 'c-${c.chatRoomId}',
          icon: Icons.chat_bubble_outline,
          title: "${c.activityTitle} Chat'i",
          message: '${c.unreadCount} yeni mesaj',
          isRead: false,
          createdAt: now,
          onOpen: () {
            ref.read(chatUnreadProvider.notifier).markRead(c.chatRoomId);
            context.push(RoutePaths.activityDetail(c.activityId));
          },
        ),
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    if (items.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.notifications_none,
        title: 'Henüz bildirim yok',
        description: 'Etkinlik istekleri, sohbet mesajları ve güncellemeler burada görünecek.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: item.onOpen,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: item.isRead ? AppColors.surface : AppColors.accentSoftBg,
              border: Border.all(color: item.isRead ? AppColors.border : const Color(0xFFFFD580)),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: item.isRead ? const Color(0xFFF3F4F6) : AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, size: 17, color: item.isRead ? AppColors.mutedForeground : AppColors.accent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      if (item.message != null) Text(item.message!, style: const TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
                      if (item.activityTitle != null)
                        Text(item.activityTitle!, style: const TextStyle(fontSize: 12, color: AppColors.accent, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(
                        Formatters.dateTimeShort(item.createdAt),
                        style: const TextStyle(fontSize: 11, color: AppColors.subtleForeground),
                      ),
                    ],
                  ),
                ),
                if (!item.isRead)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
