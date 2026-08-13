import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../application/users_actions_provider.dart';
import 'report_user_dialog.dart';

/// Ports `sosyolobi-web-2/src/components/app/ParticipantActionsMenu.tsx`.
class ParticipantActionsMenu extends ConsumerWidget {
  const ParticipantActionsMenu({required this.userId, required this.displayName, super.key});

  final String userId;
  final String displayName;

  Future<void> _handleBlock(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kullanıcıyı engelle'),
        content: Text('$displayName kullanıcısını engellemek istediğinize emin misiniz? Bu kullanıcının etkinliklerini artık görmeyeceksiniz.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Vazgeç')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Engelle')),
        ],
      ),
    );
    if (confirmed != true) return;

    await ref.read(userActionsControllerProvider.notifier).block(userId);
    if (!context.mounted) return;
    final error = ref.read(userActionsControllerProvider).hasError;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error ? 'Kullanıcı engellenemedi.' : 'Kullanıcı engellendi.')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, size: 18, color: AppColors.mutedForeground),
      onSelected: (value) {
        if (value == 'report') {
          showReportUserDialog(context, userId: userId, displayName: displayName);
        } else if (value == 'block') {
          _handleBlock(context, ref);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'report', child: Row(children: [Icon(Icons.flag_outlined, size: 16), SizedBox(width: 8), Text('Şikayet Et')])),
        const PopupMenuItem(
          value: 'block',
          child: Row(
            children: [
              Icon(Icons.block, size: 16, color: AppColors.destructive),
              SizedBox(width: 8),
              Text('Kullanıcıyı Engelle', style: TextStyle(color: AppColors.destructive)),
            ],
          ),
        ),
      ],
    );
  }
}
