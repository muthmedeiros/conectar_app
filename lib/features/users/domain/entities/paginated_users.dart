import '../../../../core/params/paginated_response.dart';
import '../entities/user_entity.dart';

class PaginatedUsers extends PaginatedResponse<UserEntity> {
  const PaginatedUsers({
    required super.data,
    required super.page,
    required super.limit,
    required super.total,
    required super.totalPages,
    required super.hasNextPage,
    required super.hasPreviousPage,
  });

  List<UserEntity> get users => data;
}
