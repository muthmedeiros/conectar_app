import 'package:dio/dio.dart';

abstract class IAuthRemoteDS {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> getCurrentUser(String uuid);
}

class AuthRemoteDSImpl implements IAuthRemoteDS {
  AuthRemoteDSImpl(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    final response = Map<String, dynamic>.from(res.data as Map);

    return response;
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser(String uuid) async {
    final res = await _dio.get('/users/$uuid');

    final response = Map<String, dynamic>.from(res.data as Map);

    return response;
  }
}
