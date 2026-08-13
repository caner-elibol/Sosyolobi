// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$incomingRequestsHash() => r'6a115c021b72cc96039177520dee7b5a72e0469c';

/// Mirrors `useIncomingRequests`/`useSentRequests` in
/// `sosyolobi-web-2/src/hooks/useJoinRequest.ts`.
///
/// Copied from [incomingRequests].
@ProviderFor(incomingRequests)
final incomingRequestsProvider =
    AutoDisposeFutureProvider<List<ActivityJoinRequest>>.internal(
      incomingRequests,
      name: r'incomingRequestsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$incomingRequestsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IncomingRequestsRef =
    AutoDisposeFutureProviderRef<List<ActivityJoinRequest>>;
String _$sentRequestsHash() => r'86d1166b51a987df3c461502f0254203164d323e';

/// See also [sentRequests].
@ProviderFor(sentRequests)
final sentRequestsProvider =
    AutoDisposeFutureProvider<List<ActivityJoinRequest>>.internal(
      sentRequests,
      name: r'sentRequestsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sentRequestsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SentRequestsRef =
    AutoDisposeFutureProviderRef<List<ActivityJoinRequest>>;
String _$requestActionsControllerHash() =>
    r'1c2cf089cc5050d4927237fcade1b3a2c2ad578e';

/// Mirrors `useJoinRequest`'s `join`/`cancel` mutations plus
/// `useIncomingRequests`'s `approve`/`reject` — grouped into one action
/// controller since they all invalidate the same request-list caches.
///
/// Copied from [RequestActionsController].
@ProviderFor(RequestActionsController)
final requestActionsControllerProvider =
    AutoDisposeAsyncNotifierProvider<RequestActionsController, void>.internal(
      RequestActionsController.new,
      name: r'requestActionsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$requestActionsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$RequestActionsController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
