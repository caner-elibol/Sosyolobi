import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/enums.dart';
import '../../activities/domain/activity.dart';
import '../data/map_activities_api.dart';

part 'map_activities_provider.g.dart';

/// Mirrors `sosyolobi-web-2/src/hooks/useMapActivities.ts`.
@riverpod
Future<List<ActivityMapItem>> mapActivities(
  Ref ref, {
  required double latitude,
  required double longitude,
  int radiusMeters = 10000,
  String? categoryId,
  GenderPreference? genderPreference,
  bool? isFree,
  DateTime? fromDate,
  DateTime? toDate,
}) {
  return ref.watch(mapActivitiesApiProvider).getMapItems(
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        categoryId: categoryId,
        genderPreference: genderPreference,
        isFree: isFree,
        fromDate: fromDate,
        toDate: toDate,
      );
}

/// All-categories variant (no `categoryId`) so map category chip counts
/// (item 5) can be derived client-side, same rationale as
/// `nearbyActivitiesAllCategories`.
@riverpod
Future<List<ActivityMapItem>> mapActivitiesAllCategories(
  Ref ref, {
  required double latitude,
  required double longitude,
  int radiusMeters = 10000,
  GenderPreference? genderPreference,
  bool? isFree,
  DateTime? fromDate,
  DateTime? toDate,
}) {
  return ref.watch(mapActivitiesApiProvider).getMapItems(
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        genderPreference: genderPreference,
        isFree: isFree,
        fromDate: fromDate,
        toDate: toDate,
      );
}
