import 'package:dio/dio.dart';

import 'api_exception.dart';

/// Unwraps `ApiResponse<T>{success,data,message}` bodies and translates
/// error bodies (`ErrorResponse{message,code,detail,errors}`, see
/// `Sosyolobi.Api/DTOs/Common/ErrorResponse.cs`) into a typed [ApiException].
///
/// Every `*Api` class in `features/*/data/` should route its Dio calls
/// through [unwrap]/[unwrapPaged] rather than reading `response.data` itself,
/// so error handling stays centralized in one place.
T unwrap<T>(Response<dynamic> response, T Function(dynamic json) fromJsonT) {
  final body = response.data;
  if (body is Map<String, dynamic> && body.containsKey('success')) {
    final success = body['success'] as bool? ?? false;
    if (!success) {
      throw _errorFrom(response);
    }
    return fromJsonT(body['data']);
  }
  // Some endpoints (e.g. GET /api/categories today) may not wrap — fall back
  // to treating the whole body as the payload.
  return fromJsonT(body);
}

List<T> unwrapList<T>(Response<dynamic> response, T Function(dynamic json) fromJsonT) {
  return unwrap<List<dynamic>>(response, (json) => (json as List<dynamic>? ?? const []))
      .map(fromJsonT)
      .toList();
}

class PagedResult<T> {
  const PagedResult({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory PagedResult.fromJson(dynamic json, T Function(dynamic json) fromJsonT) {
    final map = json as Map<String, dynamic>;
    return PagedResult(
      items: (map['items'] as List<dynamic>? ?? const []).map(fromJsonT).toList(),
      totalCount: map['totalCount'] as int? ?? 0,
      page: map['page'] as int? ?? 1,
      pageSize: map['pageSize'] as int? ?? 0,
      totalPages: map['totalPages'] as int? ?? 0,
      hasNextPage: map['hasNextPage'] as bool? ?? false,
      hasPreviousPage: map['hasPreviousPage'] as bool? ?? false,
    );
  }

  final List<T> items;
  final int totalCount;
  final int page;
  final int pageSize;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;
}

PagedResult<T> unwrapPaged<T>(Response<dynamic> response, T Function(dynamic json) fromJsonT) {
  return unwrap<PagedResult<T>>(response, (json) => PagedResult.fromJson(json, fromJsonT));
}

ApiException _errorFrom(Response<dynamic> response) {
  final body = response.data;
  if (body is Map<String, dynamic>) {
    final rawErrors = body['errors'] as Map<String, dynamic>? ?? body['Errors'] as Map<String, dynamic>?;
    final errors = rawErrors?.map((k, v) => MapEntry(k, (v as List<dynamic>).cast<String>()));
    // Two possible shapes reach here: our own ExceptionHandlingMiddleware's
    // ErrorResponse{message,code,detail,errors}, OR ASP.NET Core's automatic
    // [ApiController] model-validation ProblemDetails{title,errors} — the
    // latter fires on malformed request bodies *before* our middleware ever
    // runs, so it has no "message" field. Fall back through title, then the
    // first field-level validation message, so real validation failures
    // (e.g. an unparseable eventDate) surface something readable instead of
    // the generic default.
    final message = body['message'] as String? ??
        body['Message'] as String? ??
        body['title'] as String? ??
        errors?.values.firstOrNull?.firstOrNull;
    final code = body['code'] as String? ?? body['Code'] as String?;
    return ApiException(
      statusCode: response.statusCode,
      message: message ?? 'Bir hata oluştu. Tekrar deneyin.',
      code: code,
      errors: errors,
    );
  }
  return ApiException(
    statusCode: response.statusCode,
    message: 'Bir hata oluştu. Tekrar deneyin.',
  );
}

/// Converts a raw [DioException] (network failure, timeout, or an HTTP error
/// that already carries a parsed [Response]) into [ApiException].
ApiException apiExceptionFromDioError(DioException error) {
  final response = error.response;
  if (response != null) return _errorFrom(response);
  if (error.type == DioExceptionType.connectionTimeout || error.type == DioExceptionType.receiveTimeout) {
    return ApiException(message: 'Sunucu yanıt vermiyor. Tekrar deneyin.');
  }
  return ApiException(message: 'Sunucuya ulaşılamadı. Bağlantınızı kontrol edin.');
}

/// Runs a Dio call and converts any [DioException] it throws into
/// [ApiException] — the single place this conversion happens. Every method
/// on every `*Api` class in `features/*/data/` must wrap its `_dio.xxx()`
/// call with this (previously none did: `apiExceptionFromDioError` existed
/// but was never called anywhere, so every non-2xx response threw a raw
/// `DioException` straight past every `on ApiException catch` block in the
/// app — confirmed live: create-activity failures showed no error and no
/// success feedback because the exception was silently swallowed by
/// Flutter's zone error handler instead of being caught by any UI code).
Future<Response<T>> guardDio<T>(Future<Response<T>> Function() request) async {
  try {
    return await request();
  } on DioException catch (e) {
    throw apiExceptionFromDioError(e);
  }
}
