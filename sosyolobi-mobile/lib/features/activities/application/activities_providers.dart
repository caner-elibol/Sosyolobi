import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/activities_api.dart';
import '../domain/activity.dart';
import '../domain/create_activity_request.dart';
import 'map_activities_invalidation.dart';

part 'activities_providers.g.dart';

/// Mirrors `sosyolobi-web-2/src/hooks/useNearbyActivities.ts`.
@riverpod
Future<List<Activity>> nearbyActivities(
  Ref ref, {
  required double latitude,
  required double longitude,
  int radiusMeters = 10000,
  String? categoryId,
}) {
  return ref.watch(activitiesApiProvider).getNearby(
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        categoryId: categoryId,
      );
}

/// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.
@riverpod
Future<ActivityDetail> activityDetail(Ref ref, String id) {
  return ref.watch(activitiesApiProvider).getById(id);
}

/// Mirrors `useCreateActivity`'s mutation — on success, invalidates
/// nearby/map activity caches the way `qc.invalidateQueries` does on web.
@riverpod
class CreateActivityController extends _$CreateActivityController {
  @override
  FutureOr<void> build() {}

  Future<Activity> submit(CreateActivityRequest request) async {
    state = const AsyncLoading();
    try {
      final activity = await ref.read(activitiesApiProvider).create(request);
      state = const AsyncData(null);
      invalidateMapActivityCaches(ref);
      return activity;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}
