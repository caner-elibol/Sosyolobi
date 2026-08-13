// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nearbyActivitiesHash() => r'c7c93315dc28666bb634864e4d84495c35772fe9';

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

/// Mirrors `sosyolobi-web-2/src/hooks/useNearbyActivities.ts`.
///
/// Copied from [nearbyActivities].
@ProviderFor(nearbyActivities)
const nearbyActivitiesProvider = NearbyActivitiesFamily();

/// Mirrors `sosyolobi-web-2/src/hooks/useNearbyActivities.ts`.
///
/// Copied from [nearbyActivities].
class NearbyActivitiesFamily extends Family<AsyncValue<List<Activity>>> {
  /// Mirrors `sosyolobi-web-2/src/hooks/useNearbyActivities.ts`.
  ///
  /// Copied from [nearbyActivities].
  const NearbyActivitiesFamily();

  /// Mirrors `sosyolobi-web-2/src/hooks/useNearbyActivities.ts`.
  ///
  /// Copied from [nearbyActivities].
  NearbyActivitiesProvider call({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    String? categoryId,
  }) {
    return NearbyActivitiesProvider(
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
      categoryId: categoryId,
    );
  }

  @override
  NearbyActivitiesProvider getProviderOverride(
    covariant NearbyActivitiesProvider provider,
  ) {
    return call(
      latitude: provider.latitude,
      longitude: provider.longitude,
      radiusMeters: provider.radiusMeters,
      categoryId: provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'nearbyActivitiesProvider';
}

/// Mirrors `sosyolobi-web-2/src/hooks/useNearbyActivities.ts`.
///
/// Copied from [nearbyActivities].
class NearbyActivitiesProvider
    extends AutoDisposeFutureProvider<List<Activity>> {
  /// Mirrors `sosyolobi-web-2/src/hooks/useNearbyActivities.ts`.
  ///
  /// Copied from [nearbyActivities].
  NearbyActivitiesProvider({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    String? categoryId,
  }) : this._internal(
         (ref) => nearbyActivities(
           ref as NearbyActivitiesRef,
           latitude: latitude,
           longitude: longitude,
           radiusMeters: radiusMeters,
           categoryId: categoryId,
         ),
         from: nearbyActivitiesProvider,
         name: r'nearbyActivitiesProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$nearbyActivitiesHash,
         dependencies: NearbyActivitiesFamily._dependencies,
         allTransitiveDependencies:
             NearbyActivitiesFamily._allTransitiveDependencies,
         latitude: latitude,
         longitude: longitude,
         radiusMeters: radiusMeters,
         categoryId: categoryId,
       );

  NearbyActivitiesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.latitude,
    required this.longitude,
    required this.radiusMeters,
    required this.categoryId,
  }) : super.internal();

  final double latitude;
  final double longitude;
  final int radiusMeters;
  final String? categoryId;

  @override
  Override overrideWith(
    FutureOr<List<Activity>> Function(NearbyActivitiesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NearbyActivitiesProvider._internal(
        (ref) => create(ref as NearbyActivitiesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Activity>> createElement() {
    return _NearbyActivitiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NearbyActivitiesProvider &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.radiusMeters == radiusMeters &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, latitude.hashCode);
    hash = _SystemHash.combine(hash, longitude.hashCode);
    hash = _SystemHash.combine(hash, radiusMeters.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NearbyActivitiesRef on AutoDisposeFutureProviderRef<List<Activity>> {
  /// The parameter `latitude` of this provider.
  double get latitude;

  /// The parameter `longitude` of this provider.
  double get longitude;

  /// The parameter `radiusMeters` of this provider.
  int get radiusMeters;

  /// The parameter `categoryId` of this provider.
  String? get categoryId;
}

class _NearbyActivitiesProviderElement
    extends AutoDisposeFutureProviderElement<List<Activity>>
    with NearbyActivitiesRef {
  _NearbyActivitiesProviderElement(super.provider);

  @override
  double get latitude => (origin as NearbyActivitiesProvider).latitude;
  @override
  double get longitude => (origin as NearbyActivitiesProvider).longitude;
  @override
  int get radiusMeters => (origin as NearbyActivitiesProvider).radiusMeters;
  @override
  String? get categoryId => (origin as NearbyActivitiesProvider).categoryId;
}

String _$activityDetailHash() => r'565c0e0ffb8c40d033062309367610ae932ff0cd';

/// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.
///
/// Copied from [activityDetail].
@ProviderFor(activityDetail)
const activityDetailProvider = ActivityDetailFamily();

/// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.
///
/// Copied from [activityDetail].
class ActivityDetailFamily extends Family<AsyncValue<ActivityDetail>> {
  /// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.
  ///
  /// Copied from [activityDetail].
  const ActivityDetailFamily();

  /// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.
  ///
  /// Copied from [activityDetail].
  ActivityDetailProvider call(String id) {
    return ActivityDetailProvider(id);
  }

  @override
  ActivityDetailProvider getProviderOverride(
    covariant ActivityDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activityDetailProvider';
}

/// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.
///
/// Copied from [activityDetail].
class ActivityDetailProvider extends AutoDisposeFutureProvider<ActivityDetail> {
  /// Mirrors `sosyolobi-web-2/src/hooks/useCreateActivity.ts`'s `useActivity`.
  ///
  /// Copied from [activityDetail].
  ActivityDetailProvider(String id)
    : this._internal(
        (ref) => activityDetail(ref as ActivityDetailRef, id),
        from: activityDetailProvider,
        name: r'activityDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$activityDetailHash,
        dependencies: ActivityDetailFamily._dependencies,
        allTransitiveDependencies:
            ActivityDetailFamily._allTransitiveDependencies,
        id: id,
      );

  ActivityDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<ActivityDetail> Function(ActivityDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActivityDetailProvider._internal(
        (ref) => create(ref as ActivityDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ActivityDetail> createElement() {
    return _ActivityDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ActivityDetailRef on AutoDisposeFutureProviderRef<ActivityDetail> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ActivityDetailProviderElement
    extends AutoDisposeFutureProviderElement<ActivityDetail>
    with ActivityDetailRef {
  _ActivityDetailProviderElement(super.provider);

  @override
  String get id => (origin as ActivityDetailProvider).id;
}

String _$createActivityControllerHash() =>
    r'abecc52356f5eed659931c7e2f86c80cb39e6e91';

/// Mirrors `useCreateActivity`'s mutation — on success, invalidates
/// nearby/map activity caches the way `qc.invalidateQueries` does on web.
///
/// Copied from [CreateActivityController].
@ProviderFor(CreateActivityController)
final createActivityControllerProvider =
    AutoDisposeAsyncNotifierProvider<CreateActivityController, void>.internal(
      CreateActivityController.new,
      name: r'createActivityControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$createActivityControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CreateActivityController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
