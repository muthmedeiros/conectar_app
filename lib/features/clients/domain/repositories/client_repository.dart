import '../entities/client.dart';

abstract class ClientRepository {
  Future<List<ClientEntity>> list({bool admin = false, String? query});
  Future<ClientEntity> create({required String name, required String document, required String ownerUserId});
  Future<ClientEntity> getById(String id);
  Future<ClientEntity> update(String id, {required String name, required String document});
  Future<void> delete(String id);
}
