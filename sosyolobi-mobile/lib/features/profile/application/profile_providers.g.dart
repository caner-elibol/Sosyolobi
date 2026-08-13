// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$publicProfileHash() => r'f5519aaf8ffbf16e3a6a7ed96c688554a8d4cd1e';

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

/// Mirrors `usePublicProfile`.
///
/// Copied from [publicProfile].
@ProviderFor(publicProfile)
const publicProfileProvider = PublicProfileFamily();

/// Mirrors `usePublicProfile`.
///
/// Copied from [publicProfile].
class PublicProfileFamily extends Family<AsyncValue<PublicProfile>> {
  /// Mirrors `usePublicProfile`.
  ///
  /// Copied from [publicProfile].
  const PublicProfileFamily();

  /// Mirrors `usePublicProfile`.
  ///
  /// Copied from [publicProfile].
  PublicProfileProvider call(String userId) {
    return PublicProfileProvider(userId);
  }

  @override
  PublicProfileProvider getProviderOverride(
    covariant PublicProfileProvider provider,
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
  String? get name => r'publicProfileProvider';
}

/// Mirrors `usePublicProfile`.
///
/// Copied from [publicProfile].
class PublicProfileProvider extends AutoDisposeFutureProvider<PublicProfile> {
  /// Mirrors `usePublicProfile`.
  ///
  /// Copied from [publicProfile].
  PublicProfileProvider(String userId)
    : this._internal(
        (ref) => publicProfile(ref as PublicProfileRef, userId),
        from: publicProfileProvider,
        name: r'publicProfileProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$publicProfileHash,
        dependencies: PublicProfileFamily._dependencies,
        allTransitiveDependencies:
            PublicProfileFamily._allTransitiveDependencies,
        userId: userId,
      );

  PublicProfileProvider._internal(
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
    FutureOr<PublicProfile> Function(PublicProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PublicProfileProvider._internal(
        (ref) => create(ref as PublicProfileRef),
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
  AutoDisposeFutureProviderElement<PublicProfile> createElement() {
    return _PublicProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicProfileProvider && other.userId == userId;
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
mixin PublicProfileRef on AutoDisposeFutureProviderRef<PublicProfile> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _PublicProfileProviderElement
    extends AutoDisposeFutureProviderElement<PublicProfile>
    with PublicProfileRef {
  _PublicProfileProviderElement(super.provider);

  @override
  String get userId => (origin as PublicProfileProvider).userId;
}

String _$myProfileHash() => r'cd20375131394d83fc5b092d2cab2730cb90dd98';

/// Mirrors `useProfile` in `sosyolobi-web-2/src/hooks/useProfile.ts`.
///
/// Copied from [MyProfile].
@ProviderFor(MyProfile)
final myProfileProvider =
    AsyncNotifierProvider<MyProfile, UserProfile>.internal(
      MyProfile.new,
      name: r'myProfileProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myProfileHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MyProfile = AsyncNotifier<UserProfile>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
