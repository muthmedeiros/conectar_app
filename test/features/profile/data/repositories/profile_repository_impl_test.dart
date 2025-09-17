import 'package:conectar_app/features/profile/data/datasources/profile_remote_ds.dart';
import 'package:conectar_app/features/profile/data/dtos/update_profile_dto.dart';
import 'package:conectar_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileRemoteDS extends Mock implements IProfileRemoteDS {}

void main() {
  late MockProfileRemoteDS mockDS;
  late ProfileRepositoryImpl repo;

  setUp(() {
    mockDS = MockProfileRemoteDS();
    repo = ProfileRepositoryImpl(mockDS);
  });

  test('updateProfile calls remote ds', () async {
    final dto = UpdateProfileDto(currentPassword: 'old', name: 'New Name');
    when(() => mockDS.updateProfile(dto)).thenAnswer((_) async {});
    await repo.updateProfile(dto);
    verify(() => mockDS.updateProfile(dto)).called(1);
  });
}
