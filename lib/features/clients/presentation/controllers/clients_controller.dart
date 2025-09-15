import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/security/access_policy.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/client.dart';
import '../../domain/repositories/client_repository.dart';

class ClientsController extends ChangeNotifier {
  ClientsController({required this.repo, required this.auth}) : policy = AccessPolicy();

  final ClientRepository repo;
  final AuthController auth;
  final AccessPolicy policy;

  bool get canViewAll => policy.canViewAllClients(auth.user);
  bool get canRegister => policy.canRegisterClients(auth.user);
  bool get canDelete => policy.canDeleteClients(auth.user);

  var loading = false;
  String? errorMsg;
  String? query;

  List<ClientEntity> items = [];

  Future<void> fetch() async {
    loading = true;
    errorMsg = null;

    notifyListeners();

    try {
      items = await repo.list(admin: canViewAll, query: query);
    } on DioException catch (e) {
      final err = ErrorMapper.fromDio(e);
      errorMsg = err.message;
      AppLogger.l.w(err.toString());
    } catch (e) {
      errorMsg = 'Unexpected error.';
      AppLogger.l.e(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void setQuery(String? q) {
    query = (q?.trim().isEmpty ?? true) ? null : q!.trim();
    fetch();
  }

  Future<bool> deleteClient(String id) async {
    if (!canDelete) {
      errorMsg = 'You don’t have permission to delete clients.';
      notifyListeners();
      return false;
    }

    loading = true;
    notifyListeners();

    try {
      errorMsg = null;
      notifyListeners();
      await repo.delete(id);
      items.removeWhere((c) => c.id == id);
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
