import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppbarNavigationButton extends StatelessWidget {
  const AppbarNavigationButton({super.key, required this.label, required this.route});

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final bool selected = GoRouterState.of(context).uri.toString().startsWith(route);

    return TextButton(
      onPressed: () => context.go(route),
      style: TextButton.styleFrom(
        foregroundColor: selected ? colorScheme.primary : colorScheme.onPrimary,
        backgroundColor: selected ? colorScheme.onPrimary : Colors.transparent,
      ),
      child: Text(label),
    );
  }
}
