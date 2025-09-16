import '../../domain/entities/client_entity.dart';
import '../../domain/entities/client_query_params.dart';
import '../../domain/entities/client_user_option.dart';
import '../../domain/entities/paginated_clients.dart';
import '../../domain/repositories/client_repository.dart';
import '../datasources/client_remote_ds.dart';
import '../dtos/create_client_dto.dart';
import '../dtos/update_client_dto.dart';
import '../models/client_model.dart';
import '../models/client_user_option_model.dart';
import '../models/paginated_clients_model.dart';

class ClientRepositoryImpl implements ClientRepository {
  ClientRepositoryImpl(this._ds);

  final IClientRemoteDS _ds;

  @override
  Future<PaginatedClients> list(ClientQueryParams params) async {
    final raw = await _ds.list(params);
    return PaginatedClientsModel.fromMap(raw);
  }

  @override
  Future<ClientEntity> create(CreateClientDto dto) async {
    final e = await _ds.create(dto);
    return ClientModel.fromMap(e);
  }

  @override
  Future<ClientEntity> getById(String id) async {
    final e = await _ds.getById(id);
    return ClientModel.fromMap(e);
  }

  @override
  Future<ClientEntity> update(String id, UpdateClientDto dto) async {
    final e = await _ds.update(id, dto);
    return ClientModel.fromMap(e);
  }

  @override
  Future<void> delete(String id) async {
    await _ds.delete(id);
  }

  @override
  Future<List<ClientUserOption>> getUsersOptions() async {
    final rawList = await _ds.getUsersOptions();
    return rawList.map((e) => ClientUserOptionModel.fromMap(e)).toList();
  }
}
