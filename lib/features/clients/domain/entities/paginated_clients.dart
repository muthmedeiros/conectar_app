import '../../../../core/params/paginated_response.dart';
import 'client_entity.dart';

class PaginatedClients extends PaginatedResponse<ClientEntity> {
  const PaginatedClients({
    required super.data,
    required super.page,
    required super.limit,
    required super.total,
    required super.totalPages,
    required super.hasNextPage,
    required super.hasPreviousPage,
  });

  List<ClientEntity> get clients => data;
}
