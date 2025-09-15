import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/tokens/spacing.dart';
import '../../../../core/widgets/brand_logo.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
            SizedBox(width: TSpacing.sm),
            BrandLogo(height: TSpacing.xl, tintColor: scheme.onPrimary),
            SizedBox(width: TSpacing.md),
            Text(
              'Clientes',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onPrimary),
            ),
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
      body: Center(
        child: Wrap(
          spacing: TSpacing.md,
          runSpacing: TSpacing.md,
          children: [
            FilledButton.tonal(
              onPressed: () => context.go('/home/clients'),
              child: const Text('Clients'),
            ),
            Visibility(
              visible: auth.isAdmin,
              child: FilledButton(
                onPressed: () => context.go('/home/clients/new'),
                child: const Text('Register Client'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
