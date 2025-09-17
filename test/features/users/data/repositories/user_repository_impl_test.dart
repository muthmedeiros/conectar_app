import 'package:conectar_app/features/users/data/datasources/user_remote_ds.dart';
import 'package:conectar_app/features/users/data/dtos/create_user_dto.dart';
import 'package:conectar_app/features/users/data/dtos/update_user_dto.dart';
import 'package:conectar_app/features/users/data/repositories/user_repository_impl.dart';
import 'package:conectar_app/features/users/domain/entities/paginated_users.dart';
import 'package:conectar_app/features/users/domain/entities/user_entity.dart';
import 'package:conectar_app/features/users/domain/entities/user_query_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRemoteDS extends Mock implements IUserRemoteDS {}

void main() {
  late MockUserRemoteDS mockDS;
  late UserRepositoryImpl repo;

  setUp(() {
    mockDS = MockUserRemoteDS();
    repo = UserRepositoryImpl(mockDS);
  });

  test('list returns PaginatedUsers', () async {
    const params = UserQueryParams();
    when(() => mockDS.list(params)).thenAnswer((_) async => {'data': [], 'total': 0});
    final result = await repo.list(params);
    expect(result, isA<PaginatedUsers>());
  });

  test('getById returns UserEntity', () async {
    when(() => mockDS.getById('1')).thenAnswer((_) async => {'id': '1'});
    final result = await repo.getById('1');
    expect(result, isA<UserEntity>());
  });

  test('create returns UserEntity', () async {
    const dto = CreateUserDto(
      name: 'Test User',
      email: 'test@example.com',
      password: 'password',
      role: 'admin',
    );
    when(() => mockDS.create(dto)).thenAnswer((_) async => {'id': '1'});
    final result = await repo.create(dto);
    expect(result, isA<UserEntity>());
  });

  test('update returns UserEntity', () async {
    const dto = UpdateUserDto(name: 'Updated');
    when(() => mockDS.update('1', dto)).thenAnswer((_) async => {'id': '1'});
    final result = await repo.update('1', dto);
    expect(result, isA<UserEntity>());
  });

  test('delete calls remote ds', () async {
    when(() => mockDS.delete('1')).thenAnswer((_) async {});
    await repo.delete('1');
    verify(() => mockDS.delete('1')).called(1);
  });
}
