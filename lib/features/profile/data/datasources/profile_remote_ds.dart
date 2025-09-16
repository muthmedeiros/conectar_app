import 'package:dio/dio.dart';
import '../dtos/update_profile_dto.dart';

abstract class IProfileRemoteDS {
  Future<void> updateProfile(UpdateProfileDto dto);
}

class ProfileRemoteDataSourceImpl implements IProfileRemoteDS {
  ProfileRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<void> updateProfile(UpdateProfileDto dto) async {
    await dio.put('/profile', data: dto.toJson());
  }
}
