import 'package:dio/dio.dart';

class UnwrapInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final body = response.data;

    if (body is Map && body.containsKey('data')) {
      response.data = body['data'];
    }

    handler.next(response);
  }
}
