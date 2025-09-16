import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/tokens/spacing.dart';
import '../../../../core/widgets/brand_logo.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../widgets/appbar_navigation_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.child});

  final Widget? child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _fetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_fetched) {
      _fetched = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final auth = context.read<AuthController>();
        if (auth.user == null) auth.getCurrentUser();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: TSpacing.sm),
            BrandLogo(height: TSpacing.xxl, tintColor: scheme.onPrimary),
            const SizedBox(width: TSpacing.md),
            const AppbarNavigationButton(label: 'Clientes', route: '/home/clients'),
            const SizedBox(width: TSpacing.md),
            const AppbarNavigationButton(label: 'Perfil', route: '/home/profile'),
            if (auth.user != null && auth.user!.isAdmin) ...[
              const SizedBox(width: TSpacing.md),
              const AppbarNavigationButton(label: 'Usuários', route: '/home/users'),
            ],
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.help_outline)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          IconButton(
            onPressed: () {
              auth.logout();
              context.go('/login');
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
          ),
        ],
      ),
      body: widget.child,
    );
  }
}
