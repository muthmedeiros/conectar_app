import 'package:conectar_app/core/enums/user_role.dart';
import 'package:conectar_app/core/logging/app_logger.dart';
import 'package:conectar_app/features/auth/domain/entities/user.dart';
import 'package:conectar_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:conectar_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;
  late AuthController controller;

  setUpAll(() {
    // Mock AppLogger.l to avoid LateInitializationError, only once
    AppLogger.l = Logger(printer: PrettyPrinter(methodCount: 0), level: Level.nothing);
  });
  setUp(() {
    mockRepo = MockAuthRepository();
    controller = AuthController(repo: mockRepo);
  });

  group('login', () {
    test('returns true on success', () async {
      when(
        () => mockRepo.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => 'userId123');
      final result = await controller.login('test@example.com', 'password');
      expect(result, isTrue);
      expect(controller.errorMsg, isNull);
      expect(controller.loading, isFalse);
    });

    test('returns false on error', () async {
      when(
        () => mockRepo.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(Exception('fail'));
      final result = await controller.login('test@example.com', 'password');
      expect(result, isFalse);
      expect(controller.errorMsg, isNotNull);
      expect(controller.loading, isFalse);
    });
  });

  group('getCurrentUser', () {
    test('sets user on success', () async {
      const user = User(id: '1', name: 'Test', email: 'test@example.com', role: UserRole.admin);
      when(() => mockRepo.getCurrentUser()).thenAnswer((_) async => user);
      await controller.getCurrentUser();
      expect(controller.user, user);
    });

    test('sets user to null on error', () async {
      when(() => mockRepo.getCurrentUser()).thenThrow(Exception('fail'));
      await controller.getCurrentUser();
      expect(controller.user, isNull);
    });
  });

  group('logout', () {
    test('calls repo.logout and clears user', () async {
      controller.user = const User(
        id: '1',
        name: 'Test',
        email: 'test@example.com',
        role: UserRole.admin,
      );
      when(() => mockRepo.logout()).thenAnswer((_) async {});
      await controller.logout();
      expect(controller.user, isNull);
      verify(() => mockRepo.logout()).called(1);
    });
  });
}
