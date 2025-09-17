import 'package:conectar_app/features/profile/data/datasources/profile_remote_ds.dart';
import 'package:conectar_app/features/profile/data/dtos/update_profile_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late MockDio mockDio;
  late ProfileRemoteDataSourceImpl ds;

  setUp(() {
    mockDio = MockDio();
    ds = ProfileRemoteDataSourceImpl(mockDio);
  });

  test('updateProfile calls dio.put', () async {
    final dto = UpdateProfileDto(currentPassword: 'old', name: 'New Name');
    when(() => mockDio.put('/profile', data: dto.toJson())).thenAnswer((_) async => MockResponse());
    await ds.updateProfile(dto);
    verify(() => mockDio.put('/profile', data: dto.toJson())).called(1);
  });
}
