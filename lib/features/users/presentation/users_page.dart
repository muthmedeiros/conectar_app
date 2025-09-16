import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/tokens/spacing.dart';
import '../../auth/presentation/controllers/auth_controller.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final user = auth.user;

    return user == null
        ? const Center(child: Text('No user loaded'))
        : Padding(
            padding: const EdgeInsets.all(TSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilledButton(
                  onPressed: () {
                    /* TODO: open edit form */
                  },
                  child: const Text('USERS'),
                ),
              ],
            ),
          );
  }
}
