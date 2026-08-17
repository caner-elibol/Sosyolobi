import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/category_icons.dart';
import '../../../../core/utils/formatters.dart';
import '../../../activities/application/activities_providers.dart';
import '../../../activities/domain/activity.dart';

/// Mini activity preview (category icon + title + category/date row) shown
/// on join-request cards — ports the preview web now shows on
/// `sosyolobi-web-2/src/app/(user)/app/requests/page.tsx`'s request cards
/// instead of a bare "Etkinliğe Git" link. Fetches via the existing
/// `activityDetailProvider` (no lighter "activity summary by id" endpoint
/// exists) and degrades to nothing while loading/on error so it never blocks
/// the rest of the card.
class RequestActivityPreview extends ConsumerWidget {
  const RequestActivityPreview({required this.activityId, super.key});

  final String activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityAsync = ref.watch(activityDetailProvider(activityId));
    return activityAsync.when(
      data: (activity) => _Preview(activity: activity),
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview({required this.activity});

  final ActivityDetail activity;

  @override
  Widget build(BuildContext context) {
    final color = CategoryIcons.colorFor(activity.categoryName);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(AppRadius.sm)),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(AppRadius.sm)),
            child: Icon(CategoryIcons.iconFor(activity.categoryName), size: 17, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text('${activity.categoryName} · ${Formatters.eventDate(activity.eventDate)}', style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
