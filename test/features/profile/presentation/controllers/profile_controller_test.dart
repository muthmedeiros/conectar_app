import 'package:conectar_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:conectar_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:conectar_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

class MockAuthController extends Mock implements AuthController {}

void main() {
  late MockProfileRepository mockRepo;
  late MockAuthController mockAuth;
  late ProfileController controller;

  setUp(() {
    mockRepo = MockProfileRepository();
    mockAuth = MockAuthController();
    controller = ProfileController(authController: mockAuth, profileRepository: mockRepo);
  });

  test('controller initializes', () {
    expect(controller, isA<ProfileController>());
  });
}
