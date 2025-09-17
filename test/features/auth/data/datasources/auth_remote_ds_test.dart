import 'package:conectar_app/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late MockDio mockDio;
  late AuthRemoteDSImpl ds;

  setUp(() {
    mockDio = MockDio();
    ds = AuthRemoteDSImpl(mockDio);
  });

  group('login', () {
    test('returns response map', () async {
      const email = 'test@example.com';
      const password = 'password';
      final responseMap = {'accessToken': 'token'};
      final mockResponse = MockResponse();
      when(() => mockResponse.data).thenReturn(responseMap);
      when(
        () => mockDio.post('/auth/login', data: any(named: 'data')),
      ).thenAnswer((_) async => mockResponse);

      final result = await ds.login(email, password);
      expect(result, responseMap);
    });
  });

  group('getCurrentUser', () {
    test('returns user map', () async {
      const uuid = 'userId123';
      final userMap = {'id': uuid, 'name': 'Test User'};
      final mockResponse = MockResponse();
      when(() => mockResponse.data).thenReturn(userMap);
      when(() => mockDio.get('/users/$uuid')).thenAnswer((_) async => mockResponse);

      final result = await ds.getCurrentUser(uuid);
      expect(result, userMap);
    });
  });
}
