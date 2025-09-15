import 'package:dio/dio.dart';

import '../storage/secure_store.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.secureStore);

  final SecureStore secureStore;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await secureStore.readAccessToken();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await secureStore.clearAll();
    }

    handler.next(err);
  }
}
