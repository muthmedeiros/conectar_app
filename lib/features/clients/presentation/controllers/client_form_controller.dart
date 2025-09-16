import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../../core/security/access_policy.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../data/dtos/create_client_dto.dart';
import '../../data/dtos/update_client_dto.dart';
import '../../domain/entities/client_entity.dart';
import '../../domain/entities/client_user_option.dart';
import '../../domain/repositories/client_repository.dart';

class ClientFormController extends ChangeNotifier {
  ClientFormController({
    required this.repo,
    required this.auth,
    String? clientId,
  }) : policy = AccessPolicy(),
       isEdit = clientId != null,
       _clientId = clientId;

  final ClientRepository repo;
  final AuthController auth;
  final AccessPolicy policy;

  final String? _clientId;
  final bool isEdit;

  ClientEntity? client;

  String? status;
  bool? conectarPlus;
  String? adminUserId;

  List<ClientUserOption> users = [];
  bool loadingUsers = true;

  var loading = false;
  String? errorMsg;
  String? successMsg;

  bool get canRegister => policy.canRegisterClients(auth.user);

  void updateStatus(String? value) {
    status = value;
    notifyListeners();
  }

  void updateConectarPlus(bool? value) {
    conectarPlus = value;
    notifyListeners();
  }

  void updateAdminUserId(String? id) {
    adminUserId = id;
    notifyListeners();
  }

  Future<void> init() async {
    if (isEdit && _clientId != null) {
      await _fetchClientById();
    }
  }

  Future<void> fetchUsers() async {
    loadingUsers = true;
    notifyListeners();

    try {
      users = await repo.getUsersOptions();
    } on DioException catch (e) {
      errorMsg = ErrorMapper.fromDio(e).message;
    } finally {
      loadingUsers = false;
      notifyListeners();
    }
  }

  Future<void> _fetchClientById() async {
    if (_clientId == null) return;

    loading = true;
    notifyListeners();

    try {
      client = await repo.getById(_clientId);
      _prefillFieldsFromClient();
    } on DioException catch (e) {
      errorMsg = ErrorMapper.fromDio(e).message;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void _prefillFieldsFromClient() {
    if (client == null) return;
    status = client!.status.value;
    conectarPlus = client!.conectarPlus;
    adminUserId = client!.adminUserId;
  }

  Future<bool> submit({
    required String corporateReason,
    required String cnpj,
    required String name,
  }) {
    if (isEdit) {
      return updateClient(
        corporateReason: corporateReason,
        cnpj: cnpj,
        name: name,
      );
    } else {
      return createClient(
        corporateReason: corporateReason,
        cnpj: cnpj,
        name: name,
      );
    }
  }

  Future<bool> createClient({
    required String corporateReason,
    required String cnpj,
    required String name,
  }) async {
    if (!canRegister) {
      errorMsg = 'You don’t have permission to create clients.';
      successMsg = null;
      notifyListeners();
      return false;
    }

    loading = true;
    errorMsg = null;
    successMsg = null;
    notifyListeners();

    final dto = CreateClientDto(
      corporateReason: corporateReason,
      cnpj: cnpj,
      name: name,
      status: status!,
      conectarPlus: conectarPlus!,
      adminUserId: adminUserId!,
    );

    try {
      await repo.create(dto);
      successMsg = 'Client created successfully.';
      errorMsg = null;
      notifyListeners();
      return true;
    } on DioException catch (e) {
      errorMsg = ErrorMapper.fromDio(e).message;
      successMsg = null;
      notifyListeners();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> updateClient({
    required String corporateReason,
    required String cnpj,
    required String name,
  }) async {
    if (client == null) return false;

    if (!policy.canEditClient(auth.user, client!.adminUserId)) {
      errorMsg = 'You don’t have permission to edit this client.';
      successMsg = null;
      notifyListeners();
      return false;
    }

    loading = true;
    errorMsg = null;
    successMsg = null;
    notifyListeners();

    final dto = UpdateClientDto(
      corporateReason: corporateReason,
      cnpj: cnpj,
      name: name,
      status: status!,
      conectarPlus: conectarPlus!,
      adminUserId: adminUserId!,
    );

    try {
      final updated = await repo.update(client!.id, dto);
      client = updated;
      successMsg = 'Client updated successfully.';
      errorMsg = null;
      notifyListeners();
      return true;
    } on DioException catch (e) {
      errorMsg = ErrorMapper.fromDio(e).message;
      successMsg = null;
      notifyListeners();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
