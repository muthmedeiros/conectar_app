import 'package:dio/dio.dart';

import '../../domain/entities/user_query_params.dart';
import '../dtos/create_user_dto.dart';
import '../dtos/update_user_dto.dart';

abstract class IUserRemoteDS {
  Future<Map<String, dynamic>> list(UserQueryParams params);
  Future<Map<String, dynamic>> getById(String id);
  Future<Map<String, dynamic>> create(CreateUserDto dto);
  Future<Map<String, dynamic>> update(String id, UpdateUserDto dto);
  Future<void> delete(String id);
}

class UserRemoteDSImpl implements IUserRemoteDS {
  UserRemoteDSImpl(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> list(UserQueryParams params) async {
    final queryParameters = params.toQueryParameters();
    final res = await _dio.get('/users', queryParameters: queryParameters);
    return Map<String, dynamic>.from(res.data as Map);
  }

  @override
  Future<Map<String, dynamic>> getById(String id) async {
    final res = await _dio.get('/users/$id');
    return Map<String, dynamic>.from(res.data as Map);
  }

  @override
  Future<Map<String, dynamic>> create(CreateUserDto dto) async {
    final res = await _dio.post('/users', data: dto.toMap());
    return Map<String, dynamic>.from(res.data as Map);
  }

  @override
  Future<Map<String, dynamic>> update(String id, UpdateUserDto dto) async {
    final res = await _dio.put('/users/$id', data: dto.toMap());
    return Map<String, dynamic>.from(res.data as Map);
  }

  @override
  Future<void> delete(String id) async {
    await _dio.delete('/users/$id');
  }
}
