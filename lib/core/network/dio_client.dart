import 'package:dio/dio.dart';

import '../storage/secure_store.dart';

Dio buildDio({required String baseUrl, required SecureStore secureStore}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  return dio;
}
