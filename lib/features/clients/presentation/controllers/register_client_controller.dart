import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/security/access_policy.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/repositories/client_repository.dart';

class RegisterClientController extends ChangeNotifier {
  RegisterClientController({required this.repo, required this.auth}) : policy = AccessPolicy();

  final ClientRepository repo;
  final AuthController auth;
  final AccessPolicy policy;

  bool get canRegister => policy.canRegisterClients(auth.user);

  var loading = false;
  String? errorMsg;

  Future<bool> createClient({
    required String name,
    required String document,
    required String ownerUserId,
  }) async {
    if (!canRegister) {
      errorMsg = 'You don’t have permission to create clients.';
      notifyListeners();
      return false;
    }

    loading = true;
    notifyListeners();

    try {
      errorMsg = null;
      notifyListeners();
      await repo.create(name: name, document: document, ownerUserId: ownerUserId);
      return true;
    } on DioException catch (e) {
      errorMsg = ErrorMapper.fromDio(e).message;
      notifyListeners();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
