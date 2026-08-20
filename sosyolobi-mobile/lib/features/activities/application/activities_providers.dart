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
  DateTime? fromDate,
  DateTime? toDate,
}) {
  return ref.watch(activitiesApiProvider).getNearby(
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        categoryId: categoryId,
        fromDate: fromDate,
        toDate: toDate,
      );
}

/// Fetches nearby activities across **all** categories (no `categoryId`
/// filter) so category chip counts (item 5) and the category-filtered view
/// can both derive from one client-side-grouped fetch — mirrors web's
/// "fetch all categories together, group client-side" approach (no new
/// backend count endpoint).
@riverpod
Future<List<Activity>> nearbyActivitiesAllCategories(
  Ref ref, {
  required double latitude,
  required double longitude,
  int radiusMeters = 10000,
  DateTime? fromDate,
  DateTime? toDate,
}) {
  return ref.watch(activitiesApiProvider).getNearby(
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        fromDate: fromDate,
        toDate: toDate,
      );
}

/// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.
@riverpod
Future<ActivityDetail> activityDetail(Ref ref, String id) {
  return ref.watch(activitiesApiProvider).getById(id);
}

/// Backs the Keşfet tab's "Katıldığım Etkinlikler" slider — upcoming
/// activities the user participates in (organizer or approved participant),
/// via `GET /api/activities/mine`. Queried through `ActivityParticipants` on
/// the backend, not `ActivityRequests`, so self-created activities (which
/// never generate a join request for their own creator) are included too.
@riverpod
Future<List<Activity>> joinedUpcomingActivities(Ref ref) {
  return ref.watch(activitiesApiProvider).getMineUpcoming();
}

/// Mirrors `useCreateActivity`'s mutation — on success, invalidates
/// nearby/map activity caches the way `qc.invalidateQueries` does on web.
@riverpod
class CreateActivityController extends _$CreateActivityController {
  @override
  FutureOr<void> build() {}

  Future<Activity> submit(CreateActivityRequest request) async {
    // Bu provider autoDispose ve UI onu hiçbir yerde `watch` etmiyor (sadece
    // `.notifier`'ı bir kerelik `read` ediyor) — yani dinleyici sayısı hep
    // sıfır. `state = AsyncLoading()` sonrası `await` ile kontrol event
    // loop'a döner dönmez Riverpod autoDispose bu provider'ı, HTTP isteği
    // hâlâ uçuştayken dispose ediyordu; dispose sırasında Riverpod'un iç
    // future completer'ı bir hatayla tamamlanıyor ama null'lanmıyor. İstek
    // başarıyla dönünce `state = AsyncData(...)` aynı completer'ı tekrar
    // tamamlamaya çalışınca "Bad state: Future already completed" ile
    // çöküyordu — API her zaman 201 dönmesine rağmen (confirmed live).
    // `ref.keepAlive()` mutation süresince disposal'ı engelliyor.
    final keepAliveLink = ref.keepAlive();
    state = const AsyncLoading();
    try {
      final activity = await ref.read(activitiesApiProvider).create(request);
      state = const AsyncData(null);
      invalidateMapActivityCaches(ref);
      return activity;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    } finally {
      keepAliveLink.close();
    }
  }
}
