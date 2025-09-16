import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/security/access_policy.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/client_entity.dart';
import '../../domain/repositories/client_repository.dart';
import '../../data/dtos/update_client_dto.dart';

class EditClientController extends ChangeNotifier {
  EditClientController({required this.repo, required this.auth}) : policy = AccessPolicy();

  final ClientRepository repo;
  final AuthController auth;
  final AccessPolicy policy;

  bool loading = false;
  String? errorMsg;

  ClientEntity? client;

  bool get canEdit => client == null ? false : policy.canEditClient(auth.user, client!.adminUserId);

  Future<void> load(String id) async {
    loading = true;
    errorMsg = null;

    notifyListeners();

    try {
      client = await repo.getById(id);
      AppLogger.l.d('Loaded client ${client!.id}');
    } on DioException catch (e) {
      final err = ErrorMapper.fromDio(e);
      errorMsg = err.message;
      AppLogger.l.w(err.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> update(UpdateClientDto dto) async {
    if (client == null) return false;

    if (!canEdit) {
      errorMsg = 'You don’t have permission to edit this client.';
      notifyListeners();
      return false;
    }

    loading = true;
    errorMsg = null;
    notifyListeners();

    try {
      final updated = await repo.update(client!.id, dto);
      client = updated;
      return true;
    } on DioException catch (e) {
      final err = ErrorMapper.fromDio(e);
      errorMsg = err.message;
      AppLogger.l.w(err.toString());
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
