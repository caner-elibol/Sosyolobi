import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/category_icons.dart';

/// Ports `sosyolobi-web-2/src/components/app/ClusterMarker.tsx`'s hover
/// tooltip — shown as a bottom sheet on cluster-marker tap instead, since
/// mobile has no hover. Lists a per-category breakdown ("Futbol 4,
/// Basketbol 2, Voleybol 3") instead of the bare cluster count the old
/// unclustered pins never even had a concept of.
class ClusterBreakdownSheet extends StatelessWidget {
  const ClusterBreakdownSheet({required this.categoryCounts, required this.totalCount, this.onZoomIn, super.key});

  final Map<String, int> categoryCounts;
  final int totalCount;
  final VoidCallback? onZoomIn;

  @override
  Widget build(BuildContext context) {
    final sorted = categoryCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    const maxShown = 6;
    final shown = sorted.take(maxShown).toList();
    final restCount = sorted.skip(maxShown).fold<int>(0, (sum, e) => sum + e.value);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$totalCount etkinlik', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          for (final entry in shown) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: CategoryIcons.colorFor(entry.key).withValues(alpha: 0.16), borderRadius: BorderRadius.circular(AppRadius.sm)),
                    child: Icon(CategoryIcons.iconFor(entry.key), size: 15, color: CategoryIcons.colorFor(entry.key)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(entry.key, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
                  Text('${entry.value}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.mutedForeground)),
                ],
              ),
            ),
          ],
          if (restCount > 0) Text('+$restCount diğer', style: const TextStyle(fontSize: 12, color: AppColors.subtleForeground)),
          if (onZoomIn != null) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(onPressed: onZoomIn, icon: const Icon(Icons.zoom_in, size: 18), label: const Text('Yakınlaştır')),
            ),
          ],
        ],
      ),
    );
  }
}
