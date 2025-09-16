import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/enums/order_direction.dart';
import '../../../../core/enums/user_role.dart';
import '../../../../core/errors/error_mapper.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/security/access_policy.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/user_query_params.dart';
import '../../domain/enums/user_order_by.dart';
import '../../domain/repositories/user_repository.dart';

class UsersController extends ChangeNotifier {
  UsersController({required this.repo, required this.auth})
    : policy = AccessPolicy();

  final UserRepository repo;
  final AuthController auth;
  final AccessPolicy policy;

  bool loading = false;
  String? errorMsg;

  String? search;
  UserRole? role;
  UserOrderBy? orderBy = UserOrderBy.createdAt;
  OrderDirection? order = OrderDirection.desc;
  int page = 1;
  int limit = 20;
  int totalItems = 0;
  int totalPages = 0;

  List<UserEntity> items = [];

  Future<void> fetch() async {
    loading = true;
    errorMsg = null;
    notifyListeners();

    final queryParams = UserQueryParams(
      search: search,
      role: role,
      orderBy: orderBy,
      order: order,
      page: page,
      limit: limit,
    );

    try {
      final paginatedUsers = await repo.list(queryParams);
      items = paginatedUsers.data;
      totalItems = paginatedUsers.total;
      totalPages = paginatedUsers.totalPages;
    } on DioException catch (e) {
      final err = ErrorMapper.fromDio(e);
      errorMsg = err.message;
      AppLogger.l.i('UsersController.fetch ERROR: ${err.message}');
    } catch (e) {
      errorMsg = 'Erro inesperado ao buscar usuários';
      AppLogger.l.i('UsersController.fetch ERROR: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void setSearch(String? value) {
    search = value;
    page = 1;
    notifyListeners();
  }

  void setRole(UserRole? value) {
    role = value;
    page = 1;
    notifyListeners();
  }

  void setOrderBy(UserOrderBy? value) {
    orderBy = value;
    page = 1;
    notifyListeners();
  }

  void setOrder(OrderDirection? value) {
    order = value;
    page = 1;
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

  void nextPage() {
    if (page < totalPages) {
      page++;
      notifyListeners();
    }
  }

  void prevPage() {
    if (page > 1) {
      page--;
      notifyListeners();
    }
  }

  void firstPage() {
    page = 1;
    notifyListeners();
  }

  void lastPage() {
    page = totalPages;
    notifyListeners();
  }

  void resetFilters() {
    search = null;
    role = null;
    orderBy = UserOrderBy.createdAt;
    order = OrderDirection.desc;
    page = 1;
    notifyListeners();
  }

  Future<void> deleteUser(String id) async {
    try {
      await repo.delete(id);
      await fetch(); // Refresh the list
    } on DioException catch (e) {
      final err = ErrorMapper.fromDio(e);
      errorMsg = err.message;
      AppLogger.l.i('UsersController.deleteUser ERROR: ${err.message}');
      notifyListeners();
    } catch (e) {
      errorMsg = 'Erro inesperado ao excluir usuário';
      AppLogger.l.i('UsersController.deleteUser ERROR: $e');
      notifyListeners();
    }
  }

  bool canEditUser(UserEntity user) {
    return policy.canEditUser(auth.user, user);
  }

  bool canDeleteUser(UserEntity user) {
    return policy.canDeleteUser(auth.user, user);
  }
}
