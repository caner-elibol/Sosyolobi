import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/enums.dart';
import '../../../core/network/envelope.dart';
import '../../activities/domain/activity.dart';
import '../data/map_activities_api.dart';

part 'nearby_activities_slider_provider.g.dart';

const _pageSize = 10;

/// Backs the Keşfet tab's paginated "Yakınımdaki Etkinlikler" slider —
/// unlike [mapActivitiesProvider] (unpaged, needed for map pins + category
/// counts), this fetches one page at a time via
/// `GET /api/activities/map/paged` and accumulates pages in [loadMore].
/// A new family instance (different filter args) always starts fresh at
/// page 1, so changing a filter "resets" pagination for free.
@riverpod
class NearbyActivitiesSlider extends _$NearbyActivitiesSlider {
  @override
  Future<PagedResult<ActivityMapItem>> build({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    String? categoryId,
    GenderPreference? genderPreference,
    bool? isFree,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return ref.watch(mapActivitiesApiProvider).getMapItemsPaged(
          latitude: latitude,
          longitude: longitude,
          radiusMeters: radiusMeters,
          categoryId: categoryId,
          genderPreference: genderPreference,
          isFree: isFree,
          fromDate: fromDate,
          toDate: toDate,
          page: 1,
          pageSize: _pageSize,
        );
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasNextPage) return;

    final next = await ref.read(mapActivitiesApiProvider).getMapItemsPaged(
          latitude: latitude,
          longitude: longitude,
          radiusMeters: radiusMeters,
          categoryId: categoryId,
          genderPreference: genderPreference,
          isFree: isFree,
          fromDate: fromDate,
          toDate: toDate,
          page: current.page + 1,
          pageSize: _pageSize,
        );

    state = AsyncData(PagedResult(
      items: [...current.items, ...next.items],
      totalCount: next.totalCount,
      page: next.page,
      pageSize: next.pageSize,
      totalPages: next.totalPages,
      hasNextPage: next.hasNextPage,
      hasPreviousPage: next.hasPreviousPage,
    ));
  }
}
