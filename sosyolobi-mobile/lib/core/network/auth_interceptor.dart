import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

import '../config/app_config.dart';
import '../storage/token_storage.dart';
import 'auth_session.dart';

/// Attaches the bearer token to every request and handles 401s by rotating
/// the refresh token (`POST /api/auth/refresh-token`), matching
/// `Sosyolobi.Api/Services/AuthService.cs`'s rotate-on-refresh behavior.
///
/// Deliberate improvement over the web client (`user-api-client.ts`), which
/// stores the refresh token but never uses it and hard-redirects on every
/// 401 after the 60-minute access-token expiry — a mobile app should stay
/// logged in across that boundary.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.ref, required this.tokenStorage});

  final Ref ref;
  final TokenStorage tokenStorage;

  /// Endpoints that must never carry (or trigger a refresh for) a bearer
  /// token — hitting them with a stale/absent token should not 401-loop.
  static const _publicPaths = ['/api/auth/send-otp', '/api/auth/verify-otp', '/api/auth/refresh-token'];

  Completer<bool>? _refreshCompleter;

  bool _isPublic(String path) => _publicPaths.any(path.contains);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!_isPublic(options.path)) {
      final token = await tokenStorage.readAccessToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final request = err.requestOptions;
    if (err.response?.statusCode != 401 || _isPublic(request.path)) {
      handler.next(err);
      return;
    }

    final refreshed = await _refreshTokens();
    if (!refreshed) {
      await tokenStorage.clear();
      ref.read(authSessionProvider.notifier).setAuthenticated(false);
      handler.next(err);
      return;
    }

    try {
      final retried = await _retry(request);
      handler.resolve(retried);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  /// Coalesces concurrent 401s behind a single in-flight refresh call so two
  /// requests failing at once don't both rotate the refresh token (the
  /// second rotation would invalidate the first's freshly-issued pair).
  Future<bool> _refreshTokens() async {
    final inFlight = _refreshCompleter;
    if (inFlight != null) return inFlight.future;

    final completer = Completer<bool>();
    _refreshCompleter = completer;
    try {
      final refreshToken = await tokenStorage.readRefreshToken();
      if (refreshToken == null) {
        completer.complete(false);
        return completer.future;
      }

      final refreshDio = Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl));
      final response = await refreshDio.post<Map<String, dynamic>>(
        '/api/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );
      final data = response.data?['data'] as Map<String, dynamic>?;
      final newAccess = data?['accessToken'] as String?;
      final newRefresh = data?['refreshToken'] as String?;
      if (newAccess == null || newRefresh == null) {
        completer.complete(false);
        return completer.future;
      }
      await tokenStorage.save(accessToken: newAccess, refreshToken: newRefresh);
      completer.complete(true);
    } catch (_) {
      completer.complete(false);
    } finally {
      _refreshCompleter = null;
    }
    return completer.future;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final token = await tokenStorage.readAccessToken();
    final options = Options(method: requestOptions.method, headers: {
      ...requestOptions.headers,
      if (token != null) 'Authorization': 'Bearer $token',
    });
    final dio = Dio(BaseOptions(baseUrl: requestOptions.baseUrl));
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
