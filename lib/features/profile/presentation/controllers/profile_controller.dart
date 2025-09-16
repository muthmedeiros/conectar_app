import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/error_mapper.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../data/dtos/update_profile_dto.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileController extends ChangeNotifier {
  ProfileController({required this.authController, required this.profileRepository});

  final AuthController authController;
  final ProfileRepository profileRepository;

  bool loading = false;
  String? errorMsg;
  bool success = false;

  Future<void> updateProfile({
    required String currentPassword,
    String? name,
    String? email,
    String? newPassword,
  }) async {
    loading = true;
    errorMsg = null;
    success = false;
    notifyListeners();
    try {
      final user = authController.user;
      if (user == null) throw Exception('Usuário não autenticado.');
      final dto = UpdateProfileDto(
        currentPassword: currentPassword,
        name: name,
        email: email,
        newPassword: newPassword,
      );
      await profileRepository.updateProfile(dto);
      success = true;
      await authController.getCurrentUser();
    } on DioException catch (e) {
      errorMsg = ErrorMapper.fromDio(e).message;
      success = false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
