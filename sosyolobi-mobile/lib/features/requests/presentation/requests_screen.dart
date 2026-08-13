import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/enums.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_widget.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/user_avatar.dart';
import '../application/requests_providers.dart';
import '../domain/activity_join_request.dart';

const _statusLabels = {
  ActivityRequestStatus.pending: ('Bekliyor', Color(0xFFB45309)),
  ActivityRequestStatus.approved: ('Onaylandı', Color(0xFF15803D)),
  ActivityRequestStatus.rejected: ('Reddedildi', Color(0xFFDC2626)),
  ActivityRequestStatus.cancelled: ('İptal', Color(0xFF6B7280)),
};

/// Ports `sosyolobi-web-2/src/app/(user)/app/requests/page.tsx`.
class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  bool _incoming = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Katılım İstekleri', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(AppRadius.md)),
            child: Row(
              children: [
                Expanded(child: _TabButton(label: 'Gelen İstekler', active: _incoming, onTap: () => setState(() => _incoming = true))),
                Expanded(child: _TabButton(label: 'Gönderdiğim', active: !_incoming, onTap: () => setState(() => _incoming = false))),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(child: _incoming ? const _IncomingList() : const _SentList()),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({required this.label, required this.active, required this.onTap});

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.surface : null,
          borderRadius: BorderRadius.circular(9),
          boxShadow: active ? [const BoxShadow(color: Color(0x14000000), blurRadius: 4)] : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: active ? AppColors.foreground : AppColors.mutedForeground),
        ),
      ),
    );
  }
}

class _SentList extends ConsumerWidget {
  const _SentList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sentAsync = ref.watch(sentRequestsProvider);
    return AsyncValueWidget<List<ActivityJoinRequest>>(
      value: sentAsync,
      data: (requests) {
        if (requests.isEmpty) {
          return const EmptyStateWidget(icon: Icons.send_outlined, title: 'Henüz istek göndermediniz', description: '');
        }
        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: requests.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final req = requests[index];
            final (label, color) = _statusLabels[req.status]!;
            return InkWell(
              onTap: () => context.push(RoutePaths.activityDetail(req.activityId)),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Aktivite #${req.activityId.length >= 6 ? req.activityId.substring(req.activityId.length - 6) : req.activityId}',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(Formatters.shortDate(req.createdAt), style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppRadius.full)),
                      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _IncomingList extends ConsumerWidget {
  const _IncomingList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomingAsync = ref.watch(incomingRequestsProvider);
    return AsyncValueWidget<List<ActivityJoinRequest>>(
      value: incomingAsync,
      data: (requests) {
        if (requests.isEmpty) {
          return const EmptyStateWidget(
            icon: Icons.inbox_outlined,
            title: 'Henüz gelen istek yok',
            description: 'Oluşturduğunuz etkinliklere katılım isteği geldiğinde burada görünecek.',
          );
        }
        final pending = requests.where((r) => r.status == ActivityRequestStatus.pending).toList();
        final others = requests.where((r) => r.status != ActivityRequestStatus.pending).toList();
        final ordered = [...pending, ...others];

        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: ordered.length + (pending.isNotEmpty ? 1 : 0),
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (pending.isNotEmpty && index == 0) {
              return Text('Bekleyen (${pending.length})', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.mutedForeground));
            }
            final req = ordered[pending.isNotEmpty ? index - 1 : index];
            return _IncomingRequestCard(request: req);
          },
        );
      },
    );
  }
}

class _IncomingRequestCard extends ConsumerWidget {
  const _IncomingRequestCard({required this.request});

  final ActivityJoinRequest request;

  Future<void> _approve(WidgetRef ref, BuildContext context) async {
    await ref.read(requestActionsControllerProvider.notifier).approve(request.id, activityId: request.activityId);
    if (!context.mounted) return;
    final error = ref.read(requestActionsControllerProvider).hasError;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error ? 'Onaylanamadı.' : 'İstek onaylandı.')));
  }

  Future<void> _reject(WidgetRef ref, BuildContext context) async {
    await ref.read(requestActionsControllerProvider.notifier).reject(request.id);
    if (!context.mounted) return;
    final error = ref.read(requestActionsControllerProvider).hasError;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error ? 'Reddedilemedi.' : 'İstek reddedildi.')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (label, color) = _statusLabels[request.status]!;
    final isPending = request.status == ActivityRequestStatus.pending;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: isPending ? const Color(0xFFFFD580) : AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserAvatar(displayName: request.user.displayName, avatarUrl: request.user.avatarUrl, size: 44),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(request.user.displayName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    if (request.user.averageRating > 0)
                      Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 4),
                          Text(
                            '${request.user.averageRating.toStringAsFixed(1)} · ${request.user.completedActivityCount} etkinlik',
                            style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppRadius.full)),
                child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
              ),
            ],
          ),
          if (request.message != null && request.message!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(AppRadius.sm)),
              child: Text('"${request.message}"', style: const TextStyle(fontSize: 13, color: Color(0xFF374151))),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => context.push(RoutePaths.activityDetail(request.activityId)),
                child: const Text('Etkinliği Gör →', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              ),
              if (isPending)
                Row(
                  children: [
                    OutlinedButton(onPressed: () => _reject(ref, context), child: const Text('Reddet')),
                    const SizedBox(width: 8),
                    ElevatedButton(onPressed: () => _approve(ref, context), child: const Text('Onayla')),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
