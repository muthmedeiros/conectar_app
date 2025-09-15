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

    await _store.saveAccessToken(token);
  }

  @override
  Future<User?> getCurrentUser() async {
    final data = await _ds.getCurrentUser();

    final user = data['user'] as Map<String, dynamic>?;

    if (user == null) return null;

    return User(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      isAdmin: (user['isAdmin'] ?? false) as bool,
    );
  }

  @override
  Future<void> logout() => _store.clearAll();
}
