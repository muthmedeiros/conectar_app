import '../entities/user.dart';

abstract class AuthRepository {
  Future<String> login({required String email, required String password});
  Future<void> logout();
  Future<User?> getCurrentUser([String? userId]);
}
