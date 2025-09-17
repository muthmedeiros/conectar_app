import 'package:conectar_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:conectar_app/features/clients/domain/repositories/client_repository.dart';
import 'package:conectar_app/features/clients/presentation/controllers/client_form_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockClientRepository extends Mock implements ClientRepository {}

class MockAuthController extends Mock implements AuthController {}

void main() {
  late MockClientRepository mockRepo;
  late MockAuthController mockAuth;
  late ClientFormController controller;

  setUp(() {
    mockRepo = MockClientRepository();
    mockAuth = MockAuthController();
    controller = ClientFormController(repo: mockRepo, auth: mockAuth);
  });

  test('controller initializes', () {
    expect(controller, isA<ClientFormController>());
  });
}
