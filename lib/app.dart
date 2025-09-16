import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';

class ConectarApp extends StatefulWidget {
  const ConectarApp({super.key});

  @override
  State<ConectarApp> createState() => _ConectarAppState();
}

class _ConectarAppState extends State<ConectarApp> {
  late final _router = buildRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController(repo: sl<AuthRepository>())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Conéctar',
        theme: AppTheme.light(),
        // TODO: implement dark theme in the future
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.light,
        routerConfig: _router,
      ),
    );
  }
}
