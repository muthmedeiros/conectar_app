import 'package:dio/dio.dart';

abstract class IClientRemoteDS {
  Future<List<Map<String, dynamic>>> list({required bool admin, String? q});
  Future<Map<String, dynamic>> create(Map<String, dynamic> payload);
  Future<Map<String, dynamic>> getById(String id);
  Future<Map<String, dynamic>> update(String id, Map<String, dynamic> payload);
  Future<void> delete(String id);
}

class ClientRemoteDSImpl implements IClientRemoteDS {
  ClientRemoteDSImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Map<String, dynamic>>> list({required bool admin, String? q}) async {
    final res = await _dio.get(
      '/clients',
      queryParameters: {'admin': admin, if (q != null) 'q': q},
    );

    final data = res.data as List;

    return data.cast<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
  }

  @override
  Future<Map<String, dynamic>> create(Map<String, dynamic> payload) async {
    final res = await _dio.post('/clients', data: payload);

    return Map<String, dynamic>.from(res.data as Map);
  }

  @override
  Future<Map<String, dynamic>> getById(String id) async {
    final res = await _dio.get('/clients/$id');

    return Map<String, dynamic>.from(res.data as Map);
  }

  @override
  Future<Map<String, dynamic>> update(String id, Map<String, dynamic> payload) async {
    final res = await _dio.put('/clients/$id', data: payload);

    return Map<String, dynamic>.from(res.data as Map);
  }

  @override
  Future<void> delete(String id) async {
    await _dio.delete('/clients/$id');
  }
}
