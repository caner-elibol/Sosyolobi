import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../storage/token_storage.dart';
import 'auth_interceptor.dart';

part 'api_client.g.dart';

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) => TokenStorage();

@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
  dio.interceptors.add(
    AuthInterceptor(ref: ref, tokenStorage: ref.watch(tokenStorageProvider)),
  );
  assert(() {
    // `requestHeader: false`: LogInterceptor'ın default'u `true`, bu da
    // Authorization header'ındaki JWT'yi (tam token) debug loglarına
    // basıyordu — debug APK'lar ve log dosyaları paylaşılabildiği için
    // gerçek bir sızıntı riski.
    dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        responseBody: false,
        requestHeader: false,
      ),
    );
    return true;
  }());
  return dio;
}
