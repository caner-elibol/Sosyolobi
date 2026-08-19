import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/enums.dart';
import '../../activities/application/activities_providers.dart';
import '../../activities/data/activities_api.dart';
import '../../activities/domain/activity.dart';
import '../data/requests_api.dart';
import '../domain/activity_join_request.dart';

part 'requests_providers.g.dart';

/// Mirrors `useIncomingRequests`/`useSentRequests` in
/// `sosyolobi-web-2/src/hooks/useJoinRequest.ts`.
@riverpod
Future<List<ActivityJoinRequest>> incomingRequests(Ref ref) => ref.watch(requestsApiProvider).incoming();

@riverpod
Future<List<ActivityJoinRequest>> sentRequests(Ref ref) => ref.watch(requestsApiProvider).sent();

/// "Katıldıklarım" tab — no dedicated backend endpoint; composed client-side
/// from the approved subset of `/api/activity-requests/sent` plus a
/// per-activity `/api/activities/{id}` detail fetch, matching web's
/// `RequestsPage` "Katıldıklarım" tab exactly. Only upcoming (not yet passed,
/// not cancelled) activities are kept.
@riverpod
Future<List<ActivityDetail>> joinedUpcomingActivities(Ref ref) async {
  final sent = await ref.watch(sentRequestsProvider.future);
  final approved = sent.where((r) => r.status == ActivityRequestStatus.approved).toList();
  final api = ref.watch(activitiesApiProvider);
  final activities = await Future.wait(approved.map((r) => api.getById(r.activityId)));

  final now = DateTime.now();
  final upcoming = activities.where((a) => a.eventDate.isAfter(now) && a.status != ActivityStatus.cancelled).toList()
    ..sort((a, b) => a.eventDate.compareTo(b.eventDate));
  return upcoming;
}

/// Mirrors `useJoinRequest`'s `join`/`cancel` mutations plus
/// `useIncomingRequests`'s `approve`/`reject` — grouped into one action
/// controller since they all invalidate the same request-list caches.
@riverpod
class RequestActionsController extends _$RequestActionsController {
  @override
  FutureOr<void> build() {}

  /// AutoDispose + no UI ever `watch`es this controller (only `.notifier`
  /// reads it) means nothing keeps it alive across the `await` inside
  /// `action` — Riverpod was tearing it down mid-request, so the `ref.read`/
  /// `ref.invalidate` calls after the await threw "Cannot use the Ref ...
  /// after it has been disposed" (confirmed live on `approve`, same root
  /// cause as `CreateActivityController.submit`'s autoDispose bug). Wrapping
  /// every mutation in a `ref.keepAlive()` link held for the call's duration
  /// fixes all of them at once.
  Future<void> _run(Future<void> Function() action) async {
    final keepAliveLink = ref.keepAlive();
    state = const AsyncLoading();
    try {
      state = await AsyncValue.guard(action);
    } finally {
      keepAliveLink.close();
    }
  }

  Future<void> join(String activityId, {String? message}) => _run(() async {
        await ref.read(requestsApiProvider).join(activityId, message: message);
        ref.invalidate(activityDetailProvider(activityId));
      });

  Future<void> cancel(String requestId, {String? activityId}) => _run(() async {
        await ref.read(requestsApiProvider).cancel(requestId);
        ref.invalidate(sentRequestsProvider);
        if (activityId != null) ref.invalidate(activityDetailProvider(activityId));
      });

  Future<void> approve(String requestId, {String? activityId}) => _run(() async {
        await ref.read(requestsApiProvider).approve(requestId);
        ref.invalidate(incomingRequestsProvider);
        if (activityId != null) ref.invalidate(activityDetailProvider(activityId));
      });

  Future<void> reject(String requestId) => _run(() async {
        await ref.read(requestsApiProvider).reject(requestId);
        ref.invalidate(incomingRequestsProvider);
      });
}
