import '../entities/user.dart';

abstract class AuthRepository {
  Future<void> login({required String email, required String password});
  Future<void> logout();
  Future<User?> getCurrentUser();
}