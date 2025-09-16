import '../../domain/entities/paginated_users.dart';
import 'user_model.dart';

class PaginatedUsersModel {
  static PaginatedUsers fromMap(Map<String, dynamic> e) {
    return PaginatedUsers(
      data: (e['data'] as List? ?? [])
          .map((item) => UserModel.fromMap(item))
          .toList(),
      total: e['total'] ?? 0,
      page: e['page'] ?? 1,
      limit: e['limit'] ?? 20,
      totalPages: e['totalPages'] ?? 0,
      hasNextPage: e['hasNext'] ?? false,
      hasPreviousPage: e['hasPrev'] ?? false,
    );
  }
}
