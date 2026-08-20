import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../activities/application/activities_providers.dart';
import '../data/requests_api.dart';
import '../domain/activity_join_request.dart';

part 'requests_providers.g.dart';

/// Mirrors `useSentRequests` in `sosyolobi-web-2/src/hooks/useJoinRequest.ts`.
@riverpod
Future<List<ActivityJoinRequest>> sentRequests(Ref ref) => ref.watch(requestsApiProvider).sent();

/// Requests (any status) for a single activity — owner-only on the backend.
/// Backs the "Katılım İstekleri" button/modal on the activity detail screen.
@riverpod
Future<List<ActivityJoinRequest>> activityRequests(Ref ref, String activityId) =>
    ref.watch(requestsApiProvider).forActivity(activityId);

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
        if (activityId != null) {
          ref.invalidate(activityDetailProvider(activityId));
          ref.invalidate(activityRequestsProvider(activityId));
        }
      });

  Future<void> reject(String requestId, {String? activityId}) => _run(() async {
        await ref.read(requestsApiProvider).reject(requestId);
        if (activityId != null) ref.invalidate(activityRequestsProvider(activityId));
      });
}
