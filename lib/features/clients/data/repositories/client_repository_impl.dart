import '../../domain/entities/client.dart';
import '../../domain/repositories/client_repository.dart';
import '../datasources/client_remote_ds.dart';

class ClientRepositoryImpl implements ClientRepository {
  ClientRepositoryImpl(this._ds);

  final IClientRemoteDS _ds;

  @override
  Future<List<ClientEntity>> list({bool admin = false, String? query}) async {
    final raw = await _ds.list(admin: admin, q: query);

    return raw
        .map(
          (e) => ClientEntity(
            id: e['id'],
            name: e['name'],
            document: e['document'],
            ownerUserId: e['ownerUserId'],
          ),
        )
        .toList();
  }

  @override
  Future<ClientEntity> create({
    required String name,
    required String document,
    required String ownerUserId,
  }) async {
    final e = await _ds.create({
      'name': name,
      'document': document,
      'ownerUserId': ownerUserId,
    });

    return ClientEntity(
      id: e['id'],
      name: e['name'],
      document: e['document'],
      ownerUserId: e['ownerUserId'],
    );
  }

  @override
  Future<ClientEntity> getById(String id) async {
    final e = await _ds.getById(id);

    return ClientEntity(
      id: e['id'],
      name: e['name'],
      document: e['document'],
      ownerUserId: e['ownerUserId'],
    );
  }

  @override
  Future<ClientEntity> update(
    String id, {
    required String name,
    required String document,
  }) async {
    final e = await _ds.update(id, {'name': name, 'document': document});

    return ClientEntity(
      id: e['id'],
      name: e['name'],
      document: e['document'],
      ownerUserId: e['ownerUserId'],
    );
  }

  @override
  Future<void> delete(String id) async {
    await _ds.delete(id);
  }
}
