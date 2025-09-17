import 'package:conectar_app/features/users/data/datasources/user_remote_ds.dart';
import 'package:conectar_app/features/users/data/dtos/create_user_dto.dart';
import 'package:conectar_app/features/users/data/dtos/update_user_dto.dart';
import 'package:conectar_app/features/users/domain/entities/user_query_params.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late MockDio mockDio;
  late UserRemoteDSImpl ds;

  setUp(() {
    mockDio = MockDio();
    ds = UserRemoteDSImpl(mockDio);
  });

  test('list returns map', () async {
    const params = UserQueryParams();
    final mockResponse = MockResponse();
    when(() => mockResponse.data).thenReturn({'data': [], 'total': 0});
    when(
      () => mockDio.get('/users', queryParameters: any(named: 'queryParameters')),
    ).thenAnswer((_) async => mockResponse);
    final result = await ds.list(params);
    expect(result, isA<Map<String, dynamic>>());
  });

  test('getById returns map', () async {
    final mockResponse = MockResponse();
    when(() => mockResponse.data).thenReturn({'id': '1'});
    when(() => mockDio.get('/users/1')).thenAnswer((_) async => mockResponse);
    final result = await ds.getById('1');
    expect(result, isA<Map<String, dynamic>>());
  });

  test('create returns map', () async {
    const dto = CreateUserDto(
      name: 'Test User',
      email: 'test@example.com',
      password: 'password',
      role: 'admin',
    );
    final mockResponse = MockResponse();
    when(() => mockResponse.data).thenReturn({'id': '1'});
    when(() => mockDio.post('/users', data: dto.toMap())).thenAnswer((_) async => mockResponse);
    final result = await ds.create(dto);
    expect(result, isA<Map<String, dynamic>>());
  });

  test('update returns map', () async {
    const dto = UpdateUserDto(name: 'Updated');
    final mockResponse = MockResponse();
    when(() => mockResponse.data).thenReturn({'id': '1'});
    when(() => mockDio.put('/users/1', data: dto.toMap())).thenAnswer((_) async => mockResponse);
    final result = await ds.update('1', dto);
    expect(result, isA<Map<String, dynamic>>());
  });

  test('delete calls dio.delete', () async {
    when(() => mockDio.delete('/users/1')).thenAnswer((_) async => MockResponse());
    await ds.delete('1');
    verify(() => mockDio.delete('/users/1')).called(1);
  });
}
