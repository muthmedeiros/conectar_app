import '../../domain/entities/paginated_users.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/user_query_params.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_ds.dart';
import '../dtos/create_user_dto.dart';
import '../dtos/update_user_dto.dart';
import '../models/paginated_users_model.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._ds);

  final IUserRemoteDS _ds;

  @override
  Future<PaginatedUsers> list(UserQueryParams params) async {
    final raw = await _ds.list(params);
    return PaginatedUsersModel.fromMap(raw);
  }

  @override
  Future<UserEntity> getById(String id) async {
    final raw = await _ds.getById(id);
    return UserModel.fromMap(raw);
  }

  @override
  Future<UserEntity> create(CreateUserDto dto) async {
    final raw = await _ds.create(dto);
    return UserModel.fromMap(raw);
  }

  @override
  Future<UserEntity> update(String id, UpdateUserDto dto) async {
    final raw = await _ds.update(id, dto);
    return UserModel.fromMap(raw);
  }

  @override
  Future<void> delete(String id) async {
    await _ds.delete(id);
  }
}
