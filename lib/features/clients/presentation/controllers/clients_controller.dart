import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/enums/order_direction.dart';
import '../../../../core/errors/error_mapper.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/security/access_policy.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/client_entity.dart';
import '../../domain/entities/client_query_params.dart';
import '../../domain/enums/client_order_by.dart';
import '../../domain/enums/client_status.dart';
import '../../domain/repositories/client_repository.dart';

class ClientsController extends ChangeNotifier {
  ClientsController({required this.repo, required this.auth}) : policy = AccessPolicy();

  final ClientRepository repo;
  final AuthController auth;
  final AccessPolicy policy;

  var loading = false;
  String? errorMsg;

  String? search;
  ClientStatus? status;
  bool? conectarPlus;
  ClientOrderBy? orderBy = ClientOrderBy.createdAt;
  OrderDirection? order = OrderDirection.desc;
  int page = 1;
  int limit = 20;
  int totalPages = 0;

  List<ClientEntity> items = [];

  Future<void> fetch() async {
    loading = true;
    errorMsg = null;
    notifyListeners();

    final queryParams = ClientQueryParams(
      search: search,
      status: status,
      conectarPlus: conectarPlus,
      orderBy: orderBy,
      order: order,
      page: page,
      limit: limit,
    );

    try {
      final paginated = await repo.list(queryParams);
      items = paginated.clients;
      totalPages = paginated.totalPages;
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

  void setSearch(String? value) {
    search = (value?.trim().isEmpty ?? true) ? null : value!.trim();
    notifyListeners();
  }

  void setStatus(ClientStatus? value) {
    status = value;
    notifyListeners();
  }

  void setConectarPlus(bool? value) {
    conectarPlus = value;
    notifyListeners();
  }

  void setOrderBy(ClientOrderBy? value) {
    orderBy = value;
    notifyListeners();
  }

  void setOrder(OrderDirection? value) {
    order = value;
    notifyListeners();
  }

  void setPage(int value) {
    page = value;
    notifyListeners();
  }

  void setLimit(int value) {
    limit = value;
    notifyListeners();
  }

  Future<bool> deleteClient(String id) async {
    if (!auth.canDelete) {
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

  void clearFilters() {
    setSearch(null);
    setStatus(null);
    setConectarPlus(null);
    setOrderBy(ClientOrderBy.createdAt);
    setOrder(OrderDirection.desc);

    fetch();
  }
}
