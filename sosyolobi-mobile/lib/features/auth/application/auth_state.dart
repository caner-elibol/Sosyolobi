/// Reactive auth state — the Flutter-side stand-in for web's read-the-cookie-
/// on-mount pattern. `go_router`'s redirect and the bottom-nav badge both
/// `ref.watch` this via `authProvider`.
class AuthState {
  const AuthState({
    required this.isAuthenticated,
    this.userId,
    this.role,
    this.displayName,
  });

  const AuthState.unauthenticated()
      : isAuthenticated = false,
        userId = null,
        role = null,
        displayName = null;

  final bool isAuthenticated;
  final String? userId;
  final String? role;
  final String? displayName;
}
