import '../../data/dtos/update_profile_dto.dart';

abstract class ProfileRepository {
  Future<void> updateProfile(UpdateProfileDto dto);
}
