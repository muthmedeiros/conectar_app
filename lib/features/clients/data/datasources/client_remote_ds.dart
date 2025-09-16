import 'package:dio/dio.dart';

import '../../domain/entities/client_query_params.dart';
import '../dtos/create_client_dto.dart';
import '../dtos/update_client_dto.dart';
import '../mappers/client_list_params_mapper.dart';

abstract class IClientRemoteDS {
  Future<Map<String, dynamic>> list(ClientQueryParams params);
  Future<Map<String, dynamic>> create(CreateClientDto dto);
  Future<Map<String, dynamic>> getById(String id);
  Future<Map<String, dynamic>> update(String id, UpdateClientDto dto);
  Future<void> delete(String id);
  Future<List<Map<String, dynamic>>> getUsersOptions();
}

class ClientRemoteDSImpl implements IClientRemoteDS {
  ClientRemoteDSImpl(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> list(ClientQueryParams params) async {
    final queryParameters = ClientListParamsMapper.toQueryParameters(params);
    final res = await _dio.get('/clients', queryParameters: queryParameters);
    return Map<String, dynamic>.from(res.data as Map);
  }

  @override
  Future<Map<String, dynamic>> create(CreateClientDto dto) async {
    final res = await _dio.post('/clients', data: dto.toMap());
    return Map<String, dynamic>.from(res.data as Map);
  }

  @override
  Future<Map<String, dynamic>> getById(String id) async {
    final res = await _dio.get('/clients/$id');

    return Map<String, dynamic>.from(res.data as Map);
  }

  @override
  Future<Map<String, dynamic>> update(String id, UpdateClientDto dto) async {
    final res = await _dio.put('/clients/$id', data: dto.toMap());
    return Map<String, dynamic>.from(res.data as Map);
  }

  @override
  Future<void> delete(String id) async {
    await _dio.delete('/clients/$id');
  }

  @override
  Future<List<Map<String, dynamic>>> getUsersOptions() async {
    final res = await _dio.get('/clients/users-options');
    return List<Map<String, dynamic>>.from(res.data as List);
  }
}
