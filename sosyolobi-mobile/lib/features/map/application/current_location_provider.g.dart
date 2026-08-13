// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentLocationNotifierHash() =>
    r'3f80879b256dfc062becf71b26ef465c0d8a66ce';

/// Mirrors `sosyolobi-web-2/src/hooks/useCurrentLocation.ts`: serve a cached
/// location instantly if it's fresh (avoids a "konum alınıyor" wait on every
/// screen open), then resolve permission + a real fix in the background;
/// fall back to Istanbul if denied/unavailable.
///
/// Copied from [CurrentLocationNotifier].
@ProviderFor(CurrentLocationNotifier)
final currentLocationNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      CurrentLocationNotifier,
      CurrentLocation
    >.internal(
      CurrentLocationNotifier.new,
      name: r'currentLocationNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentLocationNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentLocationNotifier = AutoDisposeAsyncNotifier<CurrentLocation>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
