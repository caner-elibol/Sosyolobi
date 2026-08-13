import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/widgets/async_value_widget.dart';
import '../../../core/widgets/empty_state.dart';
import '../../map/application/current_location_provider.dart';
import '../../map/domain/current_location.dart';
import '../../map/presentation/widgets/filter_chips.dart';
import '../application/activities_providers.dart';
import '../application/categories_provider.dart';
import '../domain/activity.dart';
import 'widgets/activity_card.dart';

/// Ports `sosyolobi-web-2/src/app/(user)/app/activities/page.tsx` — category
/// filter goes to the backend (`GET /api/activities/nearby`), free-text
/// search is filtered client-side over the already-fetched list, matching
/// web exactly.
class ActivitiesListScreen extends ConsumerStatefulWidget {
  const ActivitiesListScreen({super.key});

  @override
  ConsumerState<ActivitiesListScreen> createState() => _ActivitiesListScreenState();
}

class _ActivitiesListScreenState extends ConsumerState<ActivitiesListScreen> {
  String? _selectedCategoryId;
  String _search = '';

  List<Activity> _applySearch(List<Activity> activities) {
    final query = _search.trim().toLowerCase();
    if (query.isEmpty) return activities;
    return activities.where((a) {
      return a.title.toLowerCase().contains(query) ||
          a.createdByDisplayName.toLowerCase().contains(query) ||
          a.categoryName.toLowerCase().contains(query) ||
          a.addressText.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(currentLocationNotifierProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, size: 20),
              hintText: 'Etkinlik, kategori veya konum ara...',
            ),
            onChanged: (value) => setState(() => _search = value),
          ),
        ),
        categoriesAsync.maybeWhen(
          data: (categories) => FilterChipsRow(
            categories: categories,
            selected: _selectedCategoryId,
            onSelect: (id) => setState(() => _selectedCategoryId = id),
          ),
          orElse: () => const SizedBox(height: 44),
        ),
        Expanded(
          child: AsyncValueWidget<CurrentLocation>(
            value: locationAsync,
            data: (location) => _buildResults(location),
          ),
        ),
      ],
    );
  }

  Widget _buildResults(CurrentLocation location) {
    final activitiesAsync = ref.watch(
      nearbyActivitiesProvider(
        latitude: location.latitude,
        longitude: location.longitude,
        categoryId: _selectedCategoryId,
      ),
    );

    return AsyncValueWidget<List<Activity>>(
      value: activitiesAsync,
      data: (activities) {
        final filtered = _applySearch(activities);
        if (filtered.isEmpty) {
          return const EmptyStateWidget(
            icon: Icons.search_off,
            title: 'Etkinlik bulunamadı',
            description: 'Arama kelimesini veya filtreyi değiştirin.',
          );
        }
        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(nearbyActivitiesProvider),
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            itemCount: filtered.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final activity = filtered[index];
              return ActivityCard(
                activity: activity,
                onTap: () => context.push(RoutePaths.activityDetail(activity.id)),
              );
            },
          ),
        );
      },
    );
  }
}
