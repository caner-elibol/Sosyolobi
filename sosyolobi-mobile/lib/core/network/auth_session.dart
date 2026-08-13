import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session.g.dart';

/// Core-level "is there currently a valid session" flag.
///
/// This exists purely so [AuthInterceptor] (infrastructure, in `core/`) can
/// signal a forced logout (refresh-token failure on a 401) without depending
/// on the richer `features/auth` `AuthNotifier` — that would invert the
/// dependency direction (`core` must not depend on `features`). The feature
/// layer's `AuthNotifier` listens to this flag and reconciles its own
/// (decoded-JWT) state from it; `go_router`'s redirect watches the feature
/// notifier, not this raw flag, directly.
@Riverpod(keepAlive: true)
class AuthSession extends _$AuthSession {
  @override
  bool build() => false;

  void setAuthenticated(bool value) => state = value;
}
