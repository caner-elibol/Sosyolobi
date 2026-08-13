import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/notifications/application/notification_hub_provider.dart';
import '../../features/notifications/application/notifications_providers.dart';
import '../router/route_paths.dart';
import '../theme/colors.dart';

/// Authenticated app shell: top bar (logo + notification bell) + bottom nav.
/// Mirrors `sosyolobi-web-2/src/components/app/{AppTopbar,AppBottomNav}.tsx`'s
/// mobile layout (search bar and desktop nav row are web-only, omitted here).
class AppShell extends ConsumerWidget {
  const AppShell({required this.child, required this.location, super.key});

  final Widget child;
  final String location;

  static const _tabs = [
    (path: RoutePaths.map, icon: Icons.place_outlined, activeIcon: Icons.place, label: 'Keşfet'),
    (path: RoutePaths.activities, icon: Icons.calendar_month_outlined, activeIcon: Icons.calendar_month, label: 'Etkinlikler'),
    (path: RoutePaths.activityCreate, icon: Icons.add, activeIcon: Icons.add, label: 'Oluştur'),
    (path: RoutePaths.requests, icon: Icons.inbox_outlined, activeIcon: Icons.inbox, label: 'İstekler'),
    (path: RoutePaths.profile, icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profil'),
  ];

  int get _currentIndex {
    for (var i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i].path) &&
          !(_tabs[i].path == RoutePaths.activities && location.startsWith(RoutePaths.activityCreate))) {
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
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.accentBright,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.place, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 8),
            const Text('Sosyolobi', style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.w700, fontSize: 17)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(RoutePaths.notifications),
            icon: Badge(
              label: Text(badgeCount > 9 ? '9+' : '$badgeCount'),
              isLabelVisible: badgeCount > 0,
              backgroundColor: AppColors.destructive,
              child: const Icon(Icons.notifications_outlined),
            ),
          ),
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

class _NavItem extends StatelessWidget {
  const _NavItem({required this.tab, required this.active, required this.onTap});

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
              decoration: const BoxDecoration(color: AppColors.accentBright, shape: BoxShape.circle),
              child: const Icon(Icons.add, color: AppColors.navy),
            )
          else ...[
            Icon(active ? tab.activeIcon : tab.icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(tab.label, style: TextStyle(fontSize: 10, color: color, fontWeight: active ? FontWeight.w600 : FontWeight.w500)),
          ],
        ],
      ),
    );
  }
}
