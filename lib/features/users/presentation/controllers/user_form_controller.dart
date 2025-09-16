import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/errors/error_mapper.dart';
import '../../../../core/security/access_policy.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../data/dtos/create_user_dto.dart';
import '../../data/dtos/update_user_dto.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class UserFormController extends ChangeNotifier {
  UserFormController({required this.repo, required this.auth, String? userId})
    : policy = AccessPolicy(),
      isEdit = userId != null,
      _userId = userId;

  final UserRepository repo;
  final AuthController auth;
  final AccessPolicy policy;

  final String? _userId;
  final bool isEdit;

  UserEntity? user;

  String? name;
  String? email;
  String? password;
  UserRole? role;

  var loading = false;
  String? errorMsg;
  String? successMsg;

  bool get canRegister => policy.canRegisterUsers(auth.user);

  void updateName(String? value) {
    name = value;
    notifyListeners();
  }

  void updateEmail(String? value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String? value) {
    password = value;
    notifyListeners();
  }

  void updateRole(UserRole? value) {
    role = value;
    notifyListeners();
  }

  Future<void> init() async {
    if (isEdit && _userId != null) {
      await _loadUser();
    } else {
      _setDefaults();
    }
  }

  Future<void> _loadUser() async {
    loading = true;
    errorMsg = null;
    notifyListeners();

    try {
      user = await repo.getById(_userId!);
      _prefillFieldsFromUser();
    } on DioException catch (e) {
      final err = ErrorMapper.fromDio(e);
      errorMsg = err.message;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void _prefillFieldsFromUser() {
    if (user == null) return;
    name = user?.name;
    email = user?.email;
    role = user?.role;
  }

  void _setDefaults() {
    name = null;
    email = null;
    password = null;
    role = UserRole.user;
    notifyListeners();
  }

  Future<bool> save() async {
    if (!_isFormValid()) return false;

    loading = true;
    errorMsg = null;
    successMsg = null;
    notifyListeners();

    try {
      if (isEdit) {
        await _updateUser();
      } else {
        await _createUser();
      }
      successMsg = isEdit
          ? 'Usuário atualizado com sucesso!'
          : 'Usuário criado com sucesso!';
      return true;
    } on DioException catch (e) {
      errorMsg = ErrorMapper.fromDio(e).message;
      return false;
    } catch (e) {
      errorMsg = 'Erro inesperado ao salvar usuário';
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> _createUser() async {
    final dto = CreateUserDto(
      name: name!,
      email: email!,
      password: password!,
      role: role!.name,
    );

    user = await repo.create(dto);
  }

  Future<void> _updateUser() async {
    final dto = UpdateUserDto(name: name, email: email, role: role!.name);

    user = await repo.update(_userId!, dto);
  }

  bool _isFormValid() {
    if (name == null || name!.trim().isEmpty) {
      errorMsg = 'Nome é obrigatório';
      notifyListeners();
      return false;
    }

    if (email == null || email!.trim().isEmpty) {
      errorMsg = 'Email é obrigatório';
      notifyListeners();
      return false;
    }

    if (!isEdit && (password == null || password!.trim().isEmpty)) {
      errorMsg = 'Senha é obrigatória';
      notifyListeners();
      return false;
    }

    if (role == null) {
      errorMsg = 'Perfil é obrigatório';
      notifyListeners();
      return false;
    }

    return true;
  }
}
