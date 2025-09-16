import '../../data/dtos/create_client_dto.dart';
import '../../data/dtos/update_client_dto.dart';
import '../entities/client_entity.dart';
import '../entities/client_query_params.dart';
import '../entities/client_user_option.dart';
import '../entities/paginated_clients.dart';

abstract class ClientRepository {
  Future<PaginatedClients> list(ClientQueryParams params);
  Future<ClientEntity> create(CreateClientDto dto);
  Future<ClientEntity> getById(String id);
  Future<ClientEntity> update(String id, UpdateClientDto dto);
  Future<void> delete(String id);
  Future<List<ClientUserOption>> getUsersOptions();
}
