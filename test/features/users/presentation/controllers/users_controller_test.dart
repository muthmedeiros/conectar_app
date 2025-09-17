import 'package:conectar_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:conectar_app/features/users/domain/repositories/user_repository.dart';
import 'package:conectar_app/features/users/presentation/controllers/users_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthController extends Mock implements AuthController {}

void main() {
  late MockUserRepository mockRepo;
  late MockAuthController mockAuth;
  late UsersController controller;

  setUp(() {
    mockRepo = MockUserRepository();
    mockAuth = MockAuthController();
    controller = UsersController(repo: mockRepo, auth: mockAuth);
  });

  test('controller initializes', () {
    expect(controller, isA<UsersController>());
  });
}
