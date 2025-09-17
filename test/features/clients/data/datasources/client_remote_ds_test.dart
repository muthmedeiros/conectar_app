import 'package:conectar_app/features/clients/data/datasources/client_remote_ds.dart';
import 'package:conectar_app/features/clients/data/dtos/create_client_dto.dart';
import 'package:conectar_app/features/clients/data/dtos/update_client_dto.dart';
import 'package:conectar_app/features/clients/domain/entities/client_query_params.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late MockDio mockDio;
  late ClientRemoteDSImpl ds;

  setUp(() {
    mockDio = MockDio();
    ds = ClientRemoteDSImpl(mockDio);
  });

  test('list returns map', () async {
    const params = ClientQueryParams();
    final mockResponse = MockResponse();
    when(() => mockResponse.data).thenReturn({'data': [], 'total': 0});
    when(
      () => mockDio.get('/clients', queryParameters: any(named: 'queryParameters')),
    ).thenAnswer((_) async => mockResponse);
    final result = await ds.list(params);
    expect(result, isA<Map<String, dynamic>>());
  });

  test('create returns map', () async {
    const dto = CreateClientDto(
      corporateReason: 'Corp',
      cnpj: '12345678000199',
      name: 'Test Client',
      status: 'active',
      conectarPlus: true,
      adminUserId: 'admin1',
    );
    final mockResponse = MockResponse();
    when(() => mockResponse.data).thenReturn({'id': '1'});
    when(() => mockDio.post('/clients', data: dto.toMap())).thenAnswer((_) async => mockResponse);
    final result = await ds.create(dto);
    expect(result, isA<Map<String, dynamic>>());
  });

  test('getById returns map', () async {
    final mockResponse = MockResponse();
    when(() => mockResponse.data).thenReturn({'id': '1'});
    when(() => mockDio.get('/clients/1')).thenAnswer((_) async => mockResponse);
    final result = await ds.getById('1');
    expect(result, isA<Map<String, dynamic>>());
  });

  test('update returns map', () async {
    const dto = UpdateClientDto(
      corporateReason: 'Corp',
      cnpj: '12345678000199',
      name: 'Test Client',
      status: 'active',
      conectarPlus: true,
      adminUserId: 'admin1',
    );
    final mockResponse = MockResponse();
    when(() => mockResponse.data).thenReturn({'id': '1'});
    when(() => mockDio.put('/clients/1', data: dto.toMap())).thenAnswer((_) async => mockResponse);
    final result = await ds.update('1', dto);
    expect(result, isA<Map<String, dynamic>>());
  });

  test('delete calls dio.delete', () async {
    when(() => mockDio.delete('/clients/1')).thenAnswer((_) async => MockResponse());
    await ds.delete('1');
    verify(() => mockDio.delete('/clients/1')).called(1);
  });

  test('getUsersOptions returns list', () async {
    final mockResponse = MockResponse();
    when(() => mockResponse.data).thenReturn([
      {'id': '1'},
    ]);
    when(() => mockDio.get('/clients/users-options')).thenAnswer((_) async => mockResponse);
    final result = await ds.getUsersOptions();
    expect(result, isA<List<Map<String, dynamic>>>());
  });
}
