import '../../domain/entities/paginated_clients.dart';
import 'client_model.dart';

class PaginatedClientsModel {
  static PaginatedClients fromMap(Map<String, dynamic> raw) {
    final clients = (raw['clients'] as List?)?.map((e) => ClientModel.fromMap(e as Map<String, dynamic>)).toList() ?? [];
    return PaginatedClients(
      clients: clients,
      page: raw['page'] ?? 1,
      limit: raw['limit'] ?? 20,
      total: raw['total'] ?? clients.length,
      totalPages: raw['totalPages'] ?? 1,
      hasNextPage: raw['hasNextPage'] ?? false,
      hasPreviousPage: raw['hasPreviousPage'] ?? false,
    );
  }
}
