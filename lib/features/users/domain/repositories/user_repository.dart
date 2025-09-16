import '../../data/dtos/create_user_dto.dart';
import '../../data/dtos/update_user_dto.dart';
import '../entities/paginated_users.dart';
import '../entities/user_entity.dart';
import '../entities/user_query_params.dart';

abstract class UserRepository {
  Future<PaginatedUsers> list(UserQueryParams params);
  Future<UserEntity> getById(String id);
  Future<UserEntity> create(CreateUserDto dto);
  Future<UserEntity> update(String id, UpdateUserDto dto);
  Future<void> delete(String id);
}
