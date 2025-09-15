// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../di/service_locator.dart';
import '../storage/secure_store.dart';

Future<String?> authGuard(BuildContext context, GoRouterState state) async {
  final token = await sl<SecureStore>().readAccessToken();
  if (token == null) return '/login';

  return null;
}

Future<String?> loginGuard(BuildContext context, GoRouterState state) async {
  final token = await sl<SecureStore>().readAccessToken();
  if (token != null) return '/home';

  return null;
}

Future<String?> adminGuard(BuildContext context, GoRouterState state) async {
  final token = await sl<SecureStore>().readAccessToken();
  if (token == null) return '/login';

  final auth = context.read<AuthController>();
  if (auth.user == null) await auth.getCurrentUser();

  final isAdmin = auth.user?.isAdmin ?? false;
  if (!isAdmin) return '/home';

  return null;
}
