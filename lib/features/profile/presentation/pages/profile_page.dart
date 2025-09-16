import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/tokens/spacing.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                Text('Name: ${user.name}'),
                const SizedBox(height: TSpacing.sm),
                Text('Email: ${user.email}'),
                const SizedBox(height: TSpacing.sm),
                Text('Role: ${user.isAdmin ? 'Admin' : 'User'}'),
                const SizedBox(height: TSpacing.md),
                FilledButton(
                  onPressed: () {
                    /* TODO: open edit form */
                  },
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          );
  }
}
