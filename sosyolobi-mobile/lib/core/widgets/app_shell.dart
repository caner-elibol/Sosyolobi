import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/notifications/application/notification_hub_provider.dart';
import '../../features/notifications/application/notifications_providers.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../router/route_paths.dart';
import '../theme/colors.dart';

/// Authenticated app shell: top bar (logo + profile + notification bell) +
/// bottom nav. Mirrors `sosyolobi-web-2/src/components/app/{AppTopbar,
/// AppBottomNav}.tsx`'s mobile layout (search bar and desktop nav row are
/// web-only, omitted here).
///
/// Bottom nav has "Arkadaşlar" in the slot "Profil" used to occupy — web has
/// a dedicated nav item for friends and mobile now matches it, since friend
/// requests are frequent enough to need one-tap access; Profil moved to a
/// top-bar icon instead (still one tap, just relocated).
class AppShell extends ConsumerWidget {
  const AppShell({required this.child, required this.location, super.key});

  final Widget child;
  final String location;

  static const _tabs = [
    (
      path: RoutePaths.map,
      icon: Icons.place_outlined,
      activeIcon: Icons.place,
      label: 'Keşfet',
    ),
    (
      path: RoutePaths.activities,
      icon: Icons.calendar_month_outlined,
      activeIcon: Icons.calendar_month,
      label: 'Etkinlikler',
    ),
    (
      path: RoutePaths.activityCreate,
      icon: Icons.add,
      activeIcon: Icons.add,
      label: 'Oluştur',
    ),
    (
      path: RoutePaths.requests,
      icon: Icons.inbox_outlined,
      activeIcon: Icons.inbox,
      label: 'İstekler',
    ),
    (
      path: RoutePaths.friends,
      icon: Icons.people_outline,
      activeIcon: Icons.people,
      label: 'Arkadaşlar',
    ),
  ];

  int get _currentIndex {
    for (var i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i].path) &&
          !(_tabs[i].path == RoutePaths.activities &&
              location.startsWith(RoutePaths.activityCreate))) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badgeCount = ref.watch(unreadBadgeCountProvider);
    final activeIndex = _currentIndex;
    // Keeps the app-wide NotificationHub connection alive for the whole
    // authenticated session — AppShell is mounted for every /app/* route.
    ref.watch(notificationHubProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Image.asset(
          'assets/branding/logo_horizontal.png',
          height: 32,
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
        ),
        actions: [
          IconButton(
            // Guards against stacking multiple Profile screens from a fast
            // double-tap — simply no-ops once we're already there, instead
            // of the previous `StatefulWidget` approach (a `_navigating`
            // flag cleared only when `context.push`'s Future resolved on
            // pop), which could get stuck disabled even when no longer on
            // the profile screen (confirmed live). `location` is already
            // recomputed fresh from go_router's actual state on every
            // rebuild, so this can't get out of sync.
            onPressed: location == RoutePaths.profile
                ? null
                : () => context.push(RoutePaths.profile),
            icon: const Icon(Icons.person_outline),
          ),
          _NotificationBellButton(badgeCount: badgeCount),
        ],
      ),
      body: child,
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              for (var i = 0; i < _tabs.length; i++)
                Expanded(
                  child: _NavItem(
                    tab: _tabs[i],
                    active: i == activeIndex,
                    onTap: () => context.go(_tabs[i].path),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Toggleable bell button: tap opens [NotificationsPanel] as a bottom sheet,
/// tapping again while it's open closes it instead of pushing another copy.
/// Was previously `context.push(RoutePaths.notifications)`, a full route
/// push that stacked a new screen on every tap — this mirrors web's
/// open/close dropdown behavior instead.
class _NotificationBellButton extends StatefulWidget {
  const _NotificationBellButton({required this.badgeCount});

  final int badgeCount;

  @override
  State<_NotificationBellButton> createState() =>
      _NotificationBellButtonState();
}

class _NotificationBellButtonState extends State<_NotificationBellButton> {
  bool _isOpen = false;

  void _toggle() {
    if (_isOpen) {
      Navigator.of(context).maybePop();
      return;
    }
    setState(() => _isOpen = true);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const NotificationsPanel(),
    ).whenComplete(() {
      if (mounted) setState(() => _isOpen = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggle,
      icon: Badge(
        label: Text(widget.badgeCount > 9 ? '9+' : '${widget.badgeCount}'),
        isLabelVisible: widget.badgeCount > 0,
        backgroundColor: AppColors.destructive,
        child: Icon(
          _isOpen ? Icons.notifications : Icons.notifications_outlined,
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.active,
    required this.onTap,
  });

  final ({String path, IconData icon, IconData activeIcon, String label}) tab;
  final bool active;
  final VoidCallback onTap;

  bool get _isAccent => tab.path == RoutePaths.activityCreate;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.accent : AppColors.mutedForeground;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isAccent)
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(top: 0),
              decoration: const BoxDecoration(
                color: AppColors.accentBright,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: AppColors.navy),
            )
          else ...[
            Icon(active ? tab.activeIcon : tab.icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(
              tab.label,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
