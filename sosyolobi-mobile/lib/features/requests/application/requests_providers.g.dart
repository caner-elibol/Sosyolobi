// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors `useIncomingRequests`/`useSentRequests` in
/// `sosyolobi-web-2/src/hooks/useJoinRequest.ts`.

@ProviderFor(incomingRequests)
final incomingRequestsProvider = IncomingRequestsProvider._();

/// Mirrors `useIncomingRequests`/`useSentRequests` in
/// `sosyolobi-web-2/src/hooks/useJoinRequest.ts`.

final class IncomingRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityJoinRequest>>,
          List<ActivityJoinRequest>,
          FutureOr<List<ActivityJoinRequest>>
        >
    with
        $FutureModifier<List<ActivityJoinRequest>>,
        $FutureProvider<List<ActivityJoinRequest>> {
  /// Mirrors `useIncomingRequests`/`useSentRequests` in
  /// `sosyolobi-web-2/src/hooks/useJoinRequest.ts`.
  IncomingRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingRequestsHash();

  @$internal
  @override
  $FutureProviderElement<List<ActivityJoinRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityJoinRequest>> create(Ref ref) {
    return incomingRequests(ref);
  }
}

String _$incomingRequestsHash() => r'6a115c021b72cc96039177520dee7b5a72e0469c';

@ProviderFor(sentRequests)
final sentRequestsProvider = SentRequestsProvider._();

final class SentRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityJoinRequest>>,
          List<ActivityJoinRequest>,
          FutureOr<List<ActivityJoinRequest>>
        >
    with
        $FutureModifier<List<ActivityJoinRequest>>,
        $FutureProvider<List<ActivityJoinRequest>> {
  SentRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sentRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sentRequestsHash();

  @$internal
  @override
  $FutureProviderElement<List<ActivityJoinRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityJoinRequest>> create(Ref ref) {
    return sentRequests(ref);
  }
}

String _$sentRequestsHash() => r'86d1166b51a987df3c461502f0254203164d323e';

/// "Katıldıklarım" tab — no dedicated backend endpoint; composed client-side
/// from the approved subset of `/api/activity-requests/sent` plus a
/// per-activity `/api/activities/{id}` detail fetch, matching web's
/// `RequestsPage` "Katıldıklarım" tab exactly. Only upcoming (not yet passed,
/// not cancelled) activities are kept.

@ProviderFor(joinedUpcomingActivities)
final joinedUpcomingActivitiesProvider = JoinedUpcomingActivitiesProvider._();

/// "Katıldıklarım" tab — no dedicated backend endpoint; composed client-side
/// from the approved subset of `/api/activity-requests/sent` plus a
/// per-activity `/api/activities/{id}` detail fetch, matching web's
/// `RequestsPage` "Katıldıklarım" tab exactly. Only upcoming (not yet passed,
/// not cancelled) activities are kept.

final class JoinedUpcomingActivitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityDetail>>,
          List<ActivityDetail>,
          FutureOr<List<ActivityDetail>>
        >
    with
        $FutureModifier<List<ActivityDetail>>,
        $FutureProvider<List<ActivityDetail>> {
  /// "Katıldıklarım" tab — no dedicated backend endpoint; composed client-side
  /// from the approved subset of `/api/activity-requests/sent` plus a
  /// per-activity `/api/activities/{id}` detail fetch, matching web's
  /// `RequestsPage` "Katıldıklarım" tab exactly. Only upcoming (not yet passed,
  /// not cancelled) activities are kept.
  JoinedUpcomingActivitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'joinedUpcomingActivitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$joinedUpcomingActivitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<ActivityDetail>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityDetail>> create(Ref ref) {
    return joinedUpcomingActivities(ref);
  }
}

String _$joinedUpcomingActivitiesHash() =>
    r'80050a5d8025ced1e7922544a38b6d6befb16ae5';

/// Mirrors `useJoinRequest`'s `join`/`cancel` mutations plus
/// `useIncomingRequests`'s `approve`/`reject` — grouped into one action
/// controller since they all invalidate the same request-list caches.

@ProviderFor(RequestActionsController)
final requestActionsControllerProvider = RequestActionsControllerProvider._();

/// Mirrors `useJoinRequest`'s `join`/`cancel` mutations plus
/// `useIncomingRequests`'s `approve`/`reject` — grouped into one action
/// controller since they all invalidate the same request-list caches.
final class RequestActionsControllerProvider
    extends $AsyncNotifierProvider<RequestActionsController, void> {
  /// Mirrors `useJoinRequest`'s `join`/`cancel` mutations plus
  /// `useIncomingRequests`'s `approve`/`reject` — grouped into one action
  /// controller since they all invalidate the same request-list caches.
  RequestActionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestActionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestActionsControllerHash();

  @$internal
  @override
  RequestActionsController create() => RequestActionsController();
}

String _$requestActionsControllerHash() =>
    r'3a728b8613dbda3b99123ce502c39555841b11c2';

/// Mirrors `useJoinRequest`'s `join`/`cancel` mutations plus
/// `useIncomingRequests`'s `approve`/`reject` — grouped into one action
/// controller since they all invalidate the same request-list caches.

abstract class _$RequestActionsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
