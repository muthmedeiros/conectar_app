import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/theme/tokens/spacing.dart';
import '../../../../auth/presentation/controllers/auth_controller.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../controllers/users_controller.dart';
import 'widgets/users_filter_section.dart';
import 'widgets/users_listing_section.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UsersController>(
      create: (ctx) => UsersController(
        repo: sl<UserRepository>(),
        auth: ctx.read<AuthController>(),
      )..fetch(),
      child: const _UsersPageContent(),
    );
  }
}

class _UsersPageContent extends StatelessWidget {
  const _UsersPageContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UsersFilterSection(),
        SizedBox(height: TSpacing.md),
        Expanded(child: UsersListingSection()),
      ],
    );
  }
}
