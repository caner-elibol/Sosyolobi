// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$friendsHash() => r'd1d960a683d10e729007ca09853b8a6f30828153';

/// Mirrors `useFriends` in `sosyolobi-web-2/src/hooks/useFriends.ts`.
///
/// Copied from [friends].
@ProviderFor(friends)
final friendsProvider = AutoDisposeFutureProvider<List<Friend>>.internal(
  friends,
  name: r'friendsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$friendsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FriendsRef = AutoDisposeFutureProviderRef<List<Friend>>;
String _$incomingFriendRequestsHash() =>
    r'eb65354707b70d57c4c5770192fe9391b9221dba';

/// Mirrors `useIncomingFriendRequests`.
///
/// Copied from [incomingFriendRequests].
@ProviderFor(incomingFriendRequests)
final incomingFriendRequestsProvider =
    AutoDisposeFutureProvider<List<FriendRequest>>.internal(
      incomingFriendRequests,
      name: r'incomingFriendRequestsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$incomingFriendRequestsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IncomingFriendRequestsRef =
    AutoDisposeFutureProviderRef<List<FriendRequest>>;
String _$sentFriendRequestsHash() =>
    r'00f01c4b790ac1c33286c4e34821512f87616a51';

/// Mirrors `useSentFriendRequests`.
///
/// Copied from [sentFriendRequests].
@ProviderFor(sentFriendRequests)
final sentFriendRequestsProvider =
    AutoDisposeFutureProvider<List<FriendRequest>>.internal(
      sentFriendRequests,
      name: r'sentFriendRequestsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sentFriendRequestsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SentFriendRequestsRef =
    AutoDisposeFutureProviderRef<List<FriendRequest>>;
String _$friendActivitiesHash() => r'14cbdea260bf23ed2aed511c81b74a6fdcce7175';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Mirrors `useFriendActivities` — 200 only when the caller is friends with
/// `userId` (or it's their own id); the API returns 401 otherwise, which
/// surfaces as an `AsyncError` here for the caller to treat as "locked".
///
/// Copied from [friendActivities].
@ProviderFor(friendActivities)
const friendActivitiesProvider = FriendActivitiesFamily();

/// Mirrors `useFriendActivities` — 200 only when the caller is friends with
/// `userId` (or it's their own id); the API returns 401 otherwise, which
/// surfaces as an `AsyncError` here for the caller to treat as "locked".
///
/// Copied from [friendActivities].
class FriendActivitiesFamily extends Family<AsyncValue<List<Activity>>> {
  /// Mirrors `useFriendActivities` — 200 only when the caller is friends with
  /// `userId` (or it's their own id); the API returns 401 otherwise, which
  /// surfaces as an `AsyncError` here for the caller to treat as "locked".
  ///
  /// Copied from [friendActivities].
  const FriendActivitiesFamily();

  /// Mirrors `useFriendActivities` — 200 only when the caller is friends with
  /// `userId` (or it's their own id); the API returns 401 otherwise, which
  /// surfaces as an `AsyncError` here for the caller to treat as "locked".
  ///
  /// Copied from [friendActivities].
  FriendActivitiesProvider call(String userId) {
    return FriendActivitiesProvider(userId);
  }

  @override
  FriendActivitiesProvider getProviderOverride(
    covariant FriendActivitiesProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'friendActivitiesProvider';
}

/// Mirrors `useFriendActivities` — 200 only when the caller is friends with
/// `userId` (or it's their own id); the API returns 401 otherwise, which
/// surfaces as an `AsyncError` here for the caller to treat as "locked".
///
/// Copied from [friendActivities].
class FriendActivitiesProvider
    extends AutoDisposeFutureProvider<List<Activity>> {
  /// Mirrors `useFriendActivities` — 200 only when the caller is friends with
  /// `userId` (or it's their own id); the API returns 401 otherwise, which
  /// surfaces as an `AsyncError` here for the caller to treat as "locked".
  ///
  /// Copied from [friendActivities].
  FriendActivitiesProvider(String userId)
    : this._internal(
        (ref) => friendActivities(ref as FriendActivitiesRef, userId),
        from: friendActivitiesProvider,
        name: r'friendActivitiesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$friendActivitiesHash,
        dependencies: FriendActivitiesFamily._dependencies,
        allTransitiveDependencies:
            FriendActivitiesFamily._allTransitiveDependencies,
        userId: userId,
      );

  FriendActivitiesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<Activity>> Function(FriendActivitiesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FriendActivitiesProvider._internal(
        (ref) => create(ref as FriendActivitiesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Activity>> createElement() {
    return _FriendActivitiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FriendActivitiesProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FriendActivitiesRef on AutoDisposeFutureProviderRef<List<Activity>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FriendActivitiesProviderElement
    extends AutoDisposeFutureProviderElement<List<Activity>>
    with FriendActivitiesRef {
  _FriendActivitiesProviderElement(super.provider);

  @override
  String get userId => (origin as FriendActivitiesProvider).userId;
}

String _$friendStatusHash() => r'576ccab2c8ac99f826814676db44a173f7c72ed4';

/// Mirrors `useFriendStatus` — no single backend endpoint reports friendship
/// status between two users, so it's derived client-side by scanning the
/// friends list + both pending-request lists for `userId`.
///
/// Copied from [friendStatus].
@ProviderFor(friendStatus)
const friendStatusProvider = FriendStatusFamily();

/// Mirrors `useFriendStatus` — no single backend endpoint reports friendship
/// status between two users, so it's derived client-side by scanning the
/// friends list + both pending-request lists for `userId`.
///
/// Copied from [friendStatus].
class FriendStatusFamily extends Family<FriendStatusInfo> {
  /// Mirrors `useFriendStatus` — no single backend endpoint reports friendship
  /// status between two users, so it's derived client-side by scanning the
  /// friends list + both pending-request lists for `userId`.
  ///
  /// Copied from [friendStatus].
  const FriendStatusFamily();

  /// Mirrors `useFriendStatus` — no single backend endpoint reports friendship
  /// status between two users, so it's derived client-side by scanning the
  /// friends list + both pending-request lists for `userId`.
  ///
  /// Copied from [friendStatus].
  FriendStatusProvider call(String userId) {
    return FriendStatusProvider(userId);
  }

  @override
  FriendStatusProvider getProviderOverride(
    covariant FriendStatusProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'friendStatusProvider';
}

/// Mirrors `useFriendStatus` — no single backend endpoint reports friendship
/// status between two users, so it's derived client-side by scanning the
/// friends list + both pending-request lists for `userId`.
///
/// Copied from [friendStatus].
class FriendStatusProvider extends AutoDisposeProvider<FriendStatusInfo> {
  /// Mirrors `useFriendStatus` — no single backend endpoint reports friendship
  /// status between two users, so it's derived client-side by scanning the
  /// friends list + both pending-request lists for `userId`.
  ///
  /// Copied from [friendStatus].
  FriendStatusProvider(String userId)
    : this._internal(
        (ref) => friendStatus(ref as FriendStatusRef, userId),
        from: friendStatusProvider,
        name: r'friendStatusProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$friendStatusHash,
        dependencies: FriendStatusFamily._dependencies,
        allTransitiveDependencies:
            FriendStatusFamily._allTransitiveDependencies,
        userId: userId,
      );

  FriendStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FriendStatusInfo Function(FriendStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FriendStatusProvider._internal(
        (ref) => create(ref as FriendStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<FriendStatusInfo> createElement() {
    return _FriendStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FriendStatusProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FriendStatusRef on AutoDisposeProviderRef<FriendStatusInfo> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FriendStatusProviderElement
    extends AutoDisposeProviderElement<FriendStatusInfo>
    with FriendStatusRef {
  _FriendStatusProviderElement(super.provider);

  @override
  String get userId => (origin as FriendStatusProvider).userId;
}

String _$friendActionsControllerHash() =>
    r'a849eb3dbac0ebb80ccfe4640b43635145b0403f';

/// Mirrors the mutations in `useFriends.ts` — grouped into one action
/// controller (like `RequestActionsController`) since they all invalidate
/// the same friend-list/request-list caches.
///
/// Copied from [FriendActionsController].
@ProviderFor(FriendActionsController)
final friendActionsControllerProvider =
    AutoDisposeAsyncNotifierProvider<FriendActionsController, void>.internal(
      FriendActionsController.new,
      name: r'friendActionsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$friendActionsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FriendActionsController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
