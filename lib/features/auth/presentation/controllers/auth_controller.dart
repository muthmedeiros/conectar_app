import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/security/access_policy.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';

class AuthController extends ChangeNotifier {
  AuthController({required this.repo}) : policy = AccessPolicy();

  final AuthRepository repo;
  final AccessPolicy policy;

  bool loading = false;
  String? errorMsg;
  User? user;

  bool get isAdmin => user?.isAdmin ?? false;

  bool get canViewAllClients => policy.canViewAllClients(user);
  bool get canRegisterClients => policy.canRegisterClients(user);
  bool get canDeleteClients => policy.canDeleteClients(user);
  bool canEditClient(String targetUserId) => policy.canEditClient(user, targetUserId);

  bool get canViewAllUsers => policy.canViewAllUsers(user);
  bool get canRegisterUsers => policy.canRegisterUsers(user);
  bool canDeleteUser(String targetUserId) => policy.canDeleteUser(user, targetUserId);

  Future<bool> login(String email, String password) async {
    loading = true;
    errorMsg = null;

    notifyListeners();

    try {
      await repo.login(email: email, password: password);
      return true;
    } on DioException catch (e) {
      final err = ErrorMapper.fromDio(e);
      errorMsg = err.message;
      AppLogger.l.w(err.toString());
      return false;
    } catch (e) {
      errorMsg = 'Unexpected error.';
      AppLogger.l.e(e);
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> getCurrentUser() async {
    try {
      user = await repo.getCurrentUser();
    } catch (e) {
      AppLogger.l.w('Failed to load user: $e');
      user = null;
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await repo.logout();
    user = null;
    notifyListeners();
  }
}
