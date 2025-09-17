import 'package:conectar_app/core/di/service_locator.dart';
import 'package:conectar_app/core/enums/user_role.dart';
import 'package:conectar_app/features/auth/domain/entities/user.dart';
import 'package:conectar_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:conectar_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepo extends Mock implements AuthRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    sl.reset();
    sl.registerLazySingleton<AuthRepository>(() => _MockAuthRepo());
  });

  test('login success updates user', () async {
    final repo = sl<AuthRepository>() as _MockAuthRepo;
    when(
      () => repo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => '123');
    when(() => repo.getCurrentUser(any())).thenAnswer(
      (_) async => const User(id: '123', name: 'Murilo', email: 'm@x', role: UserRole.admin),
    );

    final c = AuthController(repo: sl<AuthRepository>());
    final ok = await c.login('m@x', 'pass');
    await c.getCurrentUser();

    expect(ok, true);
    expect(c.user?.name, 'Murilo');
    verify(() => repo.login(email: 'm@x', password: 'pass')).called(1);
  });
}
