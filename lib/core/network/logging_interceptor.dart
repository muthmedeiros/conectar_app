import 'dart:convert';

import 'package:dio/dio.dart';

import '../logging/app_logger.dart';

class LoggingInterceptor extends Interceptor {
  String _mask(String? v) => (v == null || v.isEmpty) ? '' : '***';

  Map<String, dynamic> _sanitizeData(dynamic data) {
    if (data is Map) {
      final m = Map<String, dynamic>.from(data);

      const sensitive = {
        'password',
        'pass',
        'token',
        'authorization',
        'access_token',
        'refresh_token',
      };

      for (final k in m.keys) {
        if (sensitive.contains(k.toLowerCase())) m[k] = '***';
      }

      return m;
    }

    return {'_raw': data.toString()};
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final headers = Map<String, dynamic>.from(options.headers);

    if (headers.containsKey('Authorization')) {
      headers['Authorization'] = _mask(headers['Authorization'] as String?);
    }

    AppLogger.l.d(
      '➡️ ${options.method} ${options.uri}\n'
      'Headers: ${jsonEncode(headers)}\n'
      'Query: ${jsonEncode(options.queryParameters)}\n'
      'Body: ${jsonEncode(_sanitizeData(options.data))}',
    );

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.l.d(
      '✅ ${response.requestOptions.method} ${response.requestOptions.uri} '
      '→ ${response.statusCode}\n'
      'Body: ${jsonEncode(_shorten(response.data))}',
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.l.w(
      '❌ ${err.requestOptions.method} ${err.requestOptions.uri} '
      '→ ${err.response?.statusCode}\n'
      'Error: ${err.message}\n'
      'Body: ${jsonEncode(_shorten(err.response?.data))}',
    );

    super.onError(err, handler);
  }

  dynamic _shorten(dynamic data) {
    final s = data.toString();

    return s.length > 2000 ? '${s.substring(0, 2000)}…' : data;
  }
}
