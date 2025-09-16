import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/storage/secure_store.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._ds, this._store);

  final IAuthRemoteDS _ds;
  final SecureStore _store;

  @override
  Future<void> login({required String email, required String password}) async {
    final data = await _ds.login(email, password);

    final token = data['accessToken'] as String;
    final userId = JwtDecoder.decode(token)['sub'];

    await Future.wait([_store.saveUserUuid(userId), _store.saveAccessToken(token)]);
  }

  @override
  Future<User?> getCurrentUser() async {
    final userId = await _store.readUserUuid();

    if (userId == null) return null;

    final data = await _ds.getCurrentUser(userId);

    final user = data as Map<String, dynamic>?;

    if (user == null) return null;

    return User(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      role: UserRole.fromString(user['role'] as String),
    );
  }

  @override
  Future<void> logout() => _store.clearAll();
}
