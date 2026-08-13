/// Thrown for any non-2xx API response. Mirrors `UserApiError` in
/// `sosyolobi-web-2/src/lib/user-api-client.ts` — `code` (e.g. `RATE_LIMITED`,
/// `PROFILE_INCOMPLETE`) drives special-case UI handling in
/// `core/widgets/api_error_snackbar.dart`.
class ApiException implements Exception {
  ApiException({
    required this.message,
    this.statusCode,
    this.code,
    this.errors,
  });

  final int? statusCode;
  final String message;
  final String? code;
  final Map<String, List<String>>? errors;

  bool get isUnauthorized => statusCode == 401;

  @override
  String toString() => 'ApiException($statusCode, $code): $message';
}
