import 'package:conectar_app/core/enums/user_role.dart';
import 'package:conectar_app/core/storage/secure_store.dart';
import 'package:conectar_app/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:conectar_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:conectar_app/features/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDS extends Mock implements IAuthRemoteDS {}

class MockSecureStore extends Mock implements SecureStore {}

void main() {
  late MockAuthRemoteDS mockDS;
  late MockSecureStore mockStore;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockDS = MockAuthRemoteDS();
    mockStore = MockSecureStore();
    repository = AuthRepositoryImpl(mockDS, mockStore);
  });

  group('login', () {
    test('returns userId and saves token', () async {
      const email = 'test@example.com';
      const password = 'password';
      const token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2VySWQxMjMifQ.abc';
      const userId = 'userId123';
      when(() => mockDS.login(email, password)).thenAnswer((_) async => {'accessToken': token});
      when(() => mockStore.saveAccessToken(token)).thenAnswer((_) async {});
      when(() => mockStore.saveUserUuid(userId)).thenAnswer((_) async {});

      final result = await repository.login(email: email, password: password);
      expect(result, userId);
      verify(() => mockStore.saveAccessToken(token)).called(1);
      verify(() => mockStore.saveUserUuid(userId)).called(1);
    });
  });

  group('getCurrentUser', () {
    test('returns User when user exists', () async {
      const userId = 'userId123';
      final userMap = {
        'id': userId,
        'name': 'Test User',
        'email': 'test@example.com',
        'role': 'admin',
      };
      when(() => mockStore.readUserUuid()).thenAnswer((_) async => userId);
      when(() => mockDS.getCurrentUser(userId)).thenAnswer((_) async => userMap);

      final user = await repository.getCurrentUser();
      expect(user, isA<User>());
      expect(user?.id, userId);
      expect(user?.role, UserRole.admin);
    });

    test('returns null when no userId', () async {
      when(() => mockStore.readUserUuid()).thenAnswer((_) async => null);
      final user = await repository.getCurrentUser();
      expect(user, isNull);
    });
  });

  group('logout', () {
    test('calls clearAll on store', () async {
      when(() => mockStore.clearAll()).thenAnswer((_) async {});
      await repository.logout();
      verify(() => mockStore.clearAll()).called(1);
    });
  });
}
