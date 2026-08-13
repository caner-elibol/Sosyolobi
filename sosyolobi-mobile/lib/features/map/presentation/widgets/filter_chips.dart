import 'package:flutter/material.dart';

import '../../../../core/domain/category.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/category_icons.dart';

/// Ports `sosyolobi-web-2/src/components/app/FilterChips.tsx` — single-select
/// category filter, "Tümü" clears it.
class FilterChipsRow extends StatelessWidget {
  const FilterChipsRow({required this.categories, required this.selected, required this.onSelect, super.key});

  final List<Category> categories;
  final String? selected;
  final ValueChanged<String?> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        children: [
          _Chip(
            active: selected == null,
            label: 'Tümü',
            icon: Icons.public,
            onTap: () => onSelect(null),
          ),
          for (final category in categories) ...[
            const SizedBox(width: 8),
            _Chip(
              active: selected == category.id,
              label: category.name,
              icon: CategoryIcons.iconFor(category.name),
              onTap: () => onSelect(selected == category.id ? null : category.id),
            ),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.active, required this.label, required this.icon, required this.onTap});

  final bool active;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.accentBright : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: active ? AppColors.accentBright : AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: active ? Colors.white : AppColors.mutedForeground),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                color: active ? Colors.white : AppColors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
