import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/envelope.dart';
import '../domain/report.dart';

part 'users_api.g.dart';

@riverpod
UsersApi usersApi(Ref ref) => UsersApi(ref.watch(apiClientProvider));

/// Mirrors `UsersController` (block) + `ReportsController` (report).
class UsersApi {
  UsersApi(this._dio);

  final Dio _dio;

  Future<void> block(String userId) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/users/$userId/block'));
  }

  Future<void> unblock(String userId) async {
    await guardDio(() => _dio.delete<Map<String, dynamic>>('/api/users/$userId/block'));
  }

  Future<void> report(CreateReportRequest request) async {
    await guardDio(() => _dio.post<Map<String, dynamic>>('/api/reports', data: request.toJson()));
  }
}
