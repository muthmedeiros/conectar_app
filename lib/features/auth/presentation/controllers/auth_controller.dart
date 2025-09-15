import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';

class AuthController extends ChangeNotifier {
  AuthController({required this.repo});

  final AuthRepository repo;

  var loading = false;
  String? errorMsg;
  User? user;

  bool get isAdmin => user?.isAdmin ?? false;

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
