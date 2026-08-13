// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authSessionHash() => r'7ed5f99dbedb79eee1f8965d5ecd834b9ac82592';

/// Core-level "is there currently a valid session" flag.
///
/// This exists purely so [AuthInterceptor] (infrastructure, in `core/`) can
/// signal a forced logout (refresh-token failure on a 401) without depending
/// on the richer `features/auth` `AuthNotifier` — that would invert the
/// dependency direction (`core` must not depend on `features`). The feature
/// layer's `AuthNotifier` listens to this flag and reconciles its own
/// (decoded-JWT) state from it; `go_router`'s redirect watches the feature
/// notifier, not this raw flag, directly.
///
/// Copied from [AuthSession].
@ProviderFor(AuthSession)
final authSessionProvider = NotifierProvider<AuthSession, bool>.internal(
  AuthSession.new,
  name: r'authSessionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authSessionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthSession = Notifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
