// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/storage/secure_store.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class SplashGate extends StatefulWidget {
  const SplashGate({super.key});

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  @override
  void initState() {
    super.initState();

    _boot();
  }

  Future<void> _boot() async {
    final token = await sl<SecureStore>().readAccessToken();

    if (token == null) {
      if (!mounted) return;
      context.go('/login');
      return;
    }

    await context.read<AuthController>().getCurrentUser();
    if (!mounted) return;

    final user = context.read<AuthController>().user;
    context.go(user == null ? '/login' : '/home');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
