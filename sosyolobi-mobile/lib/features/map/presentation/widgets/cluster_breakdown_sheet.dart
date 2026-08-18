import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/category_icons.dart';

/// Tapped-cluster bottom sheet. Clustering is now category-first (see
/// `ActivityMapCanvas`/`_MarkerGroup`), so every cluster is homogeneous —
/// this just shows that one category's icon/name/count instead of the old
/// multi-category breakdown list (ports web's single-category `ClusterMarker`
/// redesign; mobile still needs a tap sheet since there's no hover on touch).
class ClusterBreakdownSheet extends StatelessWidget {
  const ClusterBreakdownSheet({required this.categoryName, required this.count, this.onZoomIn, super.key});

  final String categoryName;
  final int count;
  final VoidCallback? onZoomIn;

  @override
  Widget build(BuildContext context) {
    final color = CategoryIcons.colorFor(categoryName);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: color.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(AppRadius.sm)),
                child: Icon(CategoryIcons.iconFor(categoryName), size: 19, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(categoryName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    Text('$count etkinlik', style: const TextStyle(fontSize: 13, color: AppColors.mutedForeground, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
          if (onZoomIn != null) ...[
            const SizedBox(height: 14),
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
