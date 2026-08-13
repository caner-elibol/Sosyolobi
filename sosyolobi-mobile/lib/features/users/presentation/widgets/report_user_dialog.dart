import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../application/users_actions_provider.dart';

const _reasons = ['Uygunsuz davranış', 'Taciz veya tehdit', 'Sahte profil', 'Spam', 'Diğer'];

/// Ports `sosyolobi-web-2/src/components/app/ReportUserModal.tsx`.
Future<void> showReportUserDialog(BuildContext context, {required String userId, required String displayName}) {
  return showDialog<void>(
    context: context,
    builder: (context) => ReportUserDialog(userId: userId, displayName: displayName),
  );
}

class ReportUserDialog extends ConsumerStatefulWidget {
  const ReportUserDialog({required this.userId, required this.displayName, super.key});

  final String userId;
  final String displayName;

  @override
  ConsumerState<ReportUserDialog> createState() => _ReportUserDialogState();
}

class _ReportUserDialogState extends ConsumerState<ReportUserDialog> {
  String _reason = _reasons.first;
  final _detailsController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    await ref.read(userActionsControllerProvider.notifier).report(
          reportedUserId: widget.userId,
          reason: _reason,
          details: _detailsController.text.trim().isEmpty ? null : _detailsController.text.trim(),
        );
    if (!mounted) return;
    final error = ref.read(userActionsControllerProvider).hasError;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error ? 'Şikayet gönderilemedi.' : 'Şikayetiniz alındı.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.displayName} kullanıcısını şikayet et'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Şikayetiniz ekibimiz tarafından incelenecektir.', style: TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _reason,
            decoration: const InputDecoration(labelText: 'Sebep'),
            items: [for (final r in _reasons) DropdownMenuItem(value: r, child: Text(r))],
            onChanged: (value) {
              if (value != null) setState(() => _reason = value);
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _detailsController,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Detay (opsiyonel)', hintText: 'Yaşadığınız durumu kısaca açıklayın...'),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('İptal')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.destructive),
          onPressed: _submitting ? null : _submit,
          child: Text(_submitting ? 'Gönderiliyor...' : 'Şikayet Et'),
        ),
      ],
    );
  }
}
