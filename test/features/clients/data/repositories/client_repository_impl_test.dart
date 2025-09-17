import 'package:conectar_app/features/clients/data/datasources/client_remote_ds.dart';
import 'package:conectar_app/features/clients/data/dtos/create_client_dto.dart';
import 'package:conectar_app/features/clients/data/dtos/update_client_dto.dart';
import 'package:conectar_app/features/clients/data/repositories/client_repository_impl.dart';
import 'package:conectar_app/features/clients/domain/entities/client_entity.dart';
import 'package:conectar_app/features/clients/domain/entities/client_query_params.dart';
import 'package:conectar_app/features/clients/domain/entities/client_user_option.dart';
import 'package:conectar_app/features/clients/domain/entities/paginated_clients.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockClientRemoteDS extends Mock implements IClientRemoteDS {}

void main() {
  late MockClientRemoteDS mockDS;
  late ClientRepositoryImpl repo;

  setUp(() {
    mockDS = MockClientRemoteDS();
    repo = ClientRepositoryImpl(mockDS);
  });

  test('list returns PaginatedClients', () async {
    const params = ClientQueryParams();
    when(() => mockDS.list(params)).thenAnswer((_) async => {'data': [], 'total': 0});
    final result = await repo.list(params);
    expect(result, isA<PaginatedClients>());
  });

  test('create returns ClientEntity', () async {
    const dto = CreateClientDto(
      corporateReason: 'Corp',
      cnpj: '12345678000199',
      name: 'Test Client',
      status: 'active',
      conectarPlus: true,
      adminUserId: 'admin1',
    );
    when(() => mockDS.create(dto)).thenAnswer((_) async => {'id': '1'});
    final result = await repo.create(dto);
    expect(result, isA<ClientEntity>());
  });

  test('getById returns ClientEntity', () async {
    when(() => mockDS.getById('1')).thenAnswer((_) async => {'id': '1'});
    final result = await repo.getById('1');
    expect(result, isA<ClientEntity>());
  });

  test('update returns ClientEntity', () async {
    const dto = UpdateClientDto(
      corporateReason: 'Corp',
      cnpj: '12345678000199',
      name: 'Test Client',
      status: 'active',
      conectarPlus: true,
      adminUserId: 'admin1',
    );
    when(() => mockDS.update('1', dto)).thenAnswer((_) async => {'id': '1'});
    final result = await repo.update('1', dto);
    expect(result, isA<ClientEntity>());
  });

  test('delete calls remote ds', () async {
    when(() => mockDS.delete('1')).thenAnswer((_) async {});
    await repo.delete('1');
    verify(() => mockDS.delete('1')).called(1);
  });

  test('getUsersOptions returns list', () async {
    when(() => mockDS.getUsersOptions()).thenAnswer(
      (_) async => [
        {'id': '1', 'name': 'Test User'},
      ],
    );
    final result = await repo.getUsersOptions();
    expect(result, isA<List<ClientUserOption>>());
    expect(result.first.id, '1');
    expect(result.first.name, 'Test User');
  });
}
