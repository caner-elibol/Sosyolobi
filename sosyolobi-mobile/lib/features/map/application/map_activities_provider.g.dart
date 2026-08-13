// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_activities_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mapActivitiesHash() => r'5e4305dc417b7856088bef9a28f84280894aeae2';

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

/// Mirrors `sosyolobi-web-2/src/hooks/useMapActivities.ts`.
///
/// Copied from [mapActivities].
@ProviderFor(mapActivities)
const mapActivitiesProvider = MapActivitiesFamily();

/// Mirrors `sosyolobi-web-2/src/hooks/useMapActivities.ts`.
///
/// Copied from [mapActivities].
class MapActivitiesFamily extends Family<AsyncValue<List<ActivityMapItem>>> {
  /// Mirrors `sosyolobi-web-2/src/hooks/useMapActivities.ts`.
  ///
  /// Copied from [mapActivities].
  const MapActivitiesFamily();

  /// Mirrors `sosyolobi-web-2/src/hooks/useMapActivities.ts`.
  ///
  /// Copied from [mapActivities].
  MapActivitiesProvider call({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    String? categoryId,
    GenderPreference? genderPreference,
    bool? isFree,
  }) {
    return MapActivitiesProvider(
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
      categoryId: categoryId,
      genderPreference: genderPreference,
      isFree: isFree,
    );
  }

  @override
  MapActivitiesProvider getProviderOverride(
    covariant MapActivitiesProvider provider,
  ) {
    return call(
      latitude: provider.latitude,
      longitude: provider.longitude,
      radiusMeters: provider.radiusMeters,
      categoryId: provider.categoryId,
      genderPreference: provider.genderPreference,
      isFree: provider.isFree,
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
  String? get name => r'mapActivitiesProvider';
}

/// Mirrors `sosyolobi-web-2/src/hooks/useMapActivities.ts`.
///
/// Copied from [mapActivities].
class MapActivitiesProvider
    extends AutoDisposeFutureProvider<List<ActivityMapItem>> {
  /// Mirrors `sosyolobi-web-2/src/hooks/useMapActivities.ts`.
  ///
  /// Copied from [mapActivities].
  MapActivitiesProvider({
    required double latitude,
    required double longitude,
    int radiusMeters = 10000,
    String? categoryId,
    GenderPreference? genderPreference,
    bool? isFree,
  }) : this._internal(
         (ref) => mapActivities(
           ref as MapActivitiesRef,
           latitude: latitude,
           longitude: longitude,
           radiusMeters: radiusMeters,
           categoryId: categoryId,
           genderPreference: genderPreference,
           isFree: isFree,
         ),
         from: mapActivitiesProvider,
         name: r'mapActivitiesProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$mapActivitiesHash,
         dependencies: MapActivitiesFamily._dependencies,
         allTransitiveDependencies:
             MapActivitiesFamily._allTransitiveDependencies,
         latitude: latitude,
         longitude: longitude,
         radiusMeters: radiusMeters,
         categoryId: categoryId,
         genderPreference: genderPreference,
         isFree: isFree,
       );

  MapActivitiesProvider._internal(
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
    required this.genderPreference,
    required this.isFree,
  }) : super.internal();

  final double latitude;
  final double longitude;
  final int radiusMeters;
  final String? categoryId;
  final GenderPreference? genderPreference;
  final bool? isFree;

  @override
  Override overrideWith(
    FutureOr<List<ActivityMapItem>> Function(MapActivitiesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MapActivitiesProvider._internal(
        (ref) => create(ref as MapActivitiesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        categoryId: categoryId,
        genderPreference: genderPreference,
        isFree: isFree,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ActivityMapItem>> createElement() {
    return _MapActivitiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MapActivitiesProvider &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.radiusMeters == radiusMeters &&
        other.categoryId == categoryId &&
        other.genderPreference == genderPreference &&
        other.isFree == isFree;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, latitude.hashCode);
    hash = _SystemHash.combine(hash, longitude.hashCode);
    hash = _SystemHash.combine(hash, radiusMeters.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);
    hash = _SystemHash.combine(hash, genderPreference.hashCode);
    hash = _SystemHash.combine(hash, isFree.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MapActivitiesRef on AutoDisposeFutureProviderRef<List<ActivityMapItem>> {
  /// The parameter `latitude` of this provider.
  double get latitude;

  /// The parameter `longitude` of this provider.
  double get longitude;

  /// The parameter `radiusMeters` of this provider.
  int get radiusMeters;

  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `genderPreference` of this provider.
  GenderPreference? get genderPreference;

  /// The parameter `isFree` of this provider.
  bool? get isFree;
}

class _MapActivitiesProviderElement
    extends AutoDisposeFutureProviderElement<List<ActivityMapItem>>
    with MapActivitiesRef {
  _MapActivitiesProviderElement(super.provider);

  @override
  double get latitude => (origin as MapActivitiesProvider).latitude;
  @override
  double get longitude => (origin as MapActivitiesProvider).longitude;
  @override
  int get radiusMeters => (origin as MapActivitiesProvider).radiusMeters;
  @override
  String? get categoryId => (origin as MapActivitiesProvider).categoryId;
  @override
  GenderPreference? get genderPreference =>
      (origin as MapActivitiesProvider).genderPreference;
  @override
  bool? get isFree => (origin as MapActivitiesProvider).isFree;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
