import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_ds.dart';
import '../dtos/update_profile_dto.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this.remoteDs);

  final IProfileRemoteDS remoteDs;

  @override
  Future<void> updateProfile(UpdateProfileDto dto) {
    return remoteDs.updateProfile(dto);
  }
}
